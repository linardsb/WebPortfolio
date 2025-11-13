# Force IPv4 connections to PostgreSQL to avoid Render's IPv6 connectivity issues
#
# Render's infrastructure prefers IPv6, but Supabase only accepts IPv4 connections.
# This initializer resolves the database hostname to an IPv4 address and updates
# the DATABASE_URL environment variable before Rails establishes database connections.

if ENV['DATABASE_URL'].present?
  require 'uri'
  require 'socket'

  puts "\n========================================="
  puts "Forcing IPv4 for database connection"
  puts "========================================="

  begin
    uri = URI.parse(ENV['DATABASE_URL'])
    original_host = uri.host

    puts "Original host: #{original_host}"

    if uri.host && uri.host !~ /^\d+\.\d+\.\d+\.\d+$/ # Not already an IP
      # Force IPv4 resolution using Socket.getaddrinfo with AF_INET family
      puts "Resolving to IPv4..."

      addrinfo = Socket.getaddrinfo(uri.host, nil, Socket::AF_INET, Socket::SOCK_STREAM)
      puts "Found #{addrinfo.length} IPv4 address(es)"

      if addrinfo.any?
        ipv4_address = addrinfo.first[3] # Extract IP address string
        puts "Selected: #{ipv4_address}"

        uri.host = ipv4_address
        ENV['DATABASE_URL'] = uri.to_s

        puts "✓ SUCCESS: Replaced #{original_host} with #{ipv4_address}"
      else
        puts "✗ ERROR: No IPv4 addresses found!"
      end
    else
      puts "Already an IP address: #{uri.host}"
    end
  rescue SocketError => e
    puts "✗ DNS RESOLUTION FAILED: #{e.message}"
    puts "  This means DNS is not available yet at initialization time."
    puts "  The application will continue but may have IPv6 connection issues."
  rescue => e
    puts "✗ UNEXPECTED ERROR: #{e.class} - #{e.message}"
    puts e.backtrace.first(3).join("\n  ")
  end

  puts "=========================================\n\n"
end
