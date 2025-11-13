ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Force IPv4 for database connections on Render
database_url = ENV['DATABASE_URL']
if database_url && !database_url.empty?
  require 'uri'
  require 'resolv'

  puts "Attempting to force IPv4 for database connection..."

  begin
    uri = URI.parse(database_url)
    puts "Database host: #{uri.host}"

    if uri.host && uri.host !~ /^\d+\.\d+\.\d+\.\d+$/ # Not already an IP
      # Force IPv4 resolution using Google's public DNS servers
      resolver = Resolv::DNS.new(nameserver: ['8.8.8.8', '8.8.4.4'])
      ipv4_records = resolver.getresources(uri.host, Resolv::DNS::Resource::IN::A)

      puts "Found #{ipv4_records.length} IPv4 records using Google DNS"

      if ipv4_records.any?
        ipv4_address = ipv4_records.first.address.to_s
        uri.host = ipv4_address
        ENV['DATABASE_URL'] = uri.to_s
        puts "✓ Forced IPv4 database connection: #{ipv4_address}"
      else
        puts "Warning: No IPv4 records found for #{uri.host}"
      end
    else
      puts "Database host is already an IP address: #{uri.host}"
    end
  rescue => e
    warn "✗ Could not force IPv4 for database: #{e.message}"
    warn e.backtrace.first(3).join("\n")
  end
end
