# Force IPv4 connections to PostgreSQL to avoid Render's IPv6 connectivity issues
#
# Render's infrastructure prefers IPv6, but Supabase only accepts IPv4 connections.
# Traditional DNS is not available during Rails initialization on Render, so we use
# DNS-over-HTTPS (DoH) to resolve the hostname via HTTP requests to Cloudflare's 1.1.1.1

if ENV['DATABASE_URL'].present?
  require 'uri'
  require 'net/http'
  require 'json'

  puts "\n========================================="
  puts "Forcing IPv4 for database connection"
  puts "========================================="

  begin
    uri = URI.parse(ENV['DATABASE_URL'])
    original_host = uri.host

    puts "Original host: #{original_host}"

    if uri.host && uri.host !~ /^\d+\.\d+\.\d+\.\d+$/ # Not already an IP
      puts "Using DNS-over-HTTPS to resolve #{uri.host}..."

      # Try multiple DoH providers
      doh_providers = [
        { name: 'Cloudflare', url: "https://1.1.1.1/dns-query?name=#{uri.host}&type=A" },
        { name: 'Google', url: "https://dns.google/resolve?name=#{uri.host}&type=A" }
      ]

      success = false

      doh_providers.each do |provider|
        next if success

        puts "\nTrying #{provider[:name]} DoH service..."

        begin
          doh_uri = URI(provider[:url])

          http = Net::HTTP.new(doh_uri.host, doh_uri.port)
          http.use_ssl = true
          http.open_timeout = 5
          http.read_timeout = 5

          request = Net::HTTP::Get.new(doh_uri)
          request['Accept'] = 'application/dns-json'

          response = http.request(request)
          puts "Response code: #{response.code}"

          if response.code == '200'
            data = JSON.parse(response.body)
            puts "Response data keys: #{data.keys.inspect}"

            if data['Answer'] && data['Answer'].any?
              puts "Answer section found with #{data['Answer'].length} record(s)"

              ipv4_addresses = data['Answer']
                .select { |answer| answer['type'] == 1 } # Type 1 = A record (IPv4)
                .map { |answer| answer['data'] }

              puts "IPv4 addresses: #{ipv4_addresses.inspect}"

              if ipv4_addresses.any?
                ipv4_address = ipv4_addresses.first
                puts "Selected: #{ipv4_address}"

                uri.host = ipv4_address
                ENV['DATABASE_URL'] = uri.to_s

                puts "✓ SUCCESS: Replaced #{original_host} with #{ipv4_address}"
                success = true
              else
                puts "✗ No IPv4 addresses in DNS response"
              end
            else
              puts "✗ No DNS answers in response"
              puts "Full response: #{response.body[0..500]}" # First 500 chars
            end
          else
            puts "✗ Request failed with status #{response.code}"
          end
        rescue => e
          puts "✗ #{provider[:name]} failed: #{e.class} - #{e.message}"
        end
      end

      puts "\n✗ ERROR: All DoH providers failed" unless success
    else
      puts "Already an IP address: #{uri.host}"
    end
  rescue => e
    puts "✗ UNEXPECTED ERROR: #{e.class} - #{e.message}"
    puts "  The application will continue but may have IPv6 connection issues."
    puts e.backtrace.first(3).join("\n  ")
  end

  puts "=========================================\n\n"
end
