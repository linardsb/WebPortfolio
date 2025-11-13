ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Force IPv4 for database connections on Render
database_url = ENV['DATABASE_URL']
if database_url && !database_url.empty?
  require 'uri'
  require 'socket'

  puts "Attempting to force IPv4 for database connection..."

  begin
    uri = URI.parse(database_url)
    puts "Database host: #{uri.host}"

    if uri.host && uri.host !~ /^\d+\.\d+\.\d+\.\d+$/ # Not already an IP
      # Force IPv4 resolution using Socket.getaddrinfo with AF_INET
      puts "Resolving #{uri.host} to IPv4..."
      addrinfo = Socket.getaddrinfo(uri.host, nil, Socket::AF_INET, Socket::SOCK_STREAM)

      puts "Found #{addrinfo.length} IPv4 address(es)"

      if addrinfo.any?
        ipv4_address = addrinfo.first[3] # Get the IP address from addrinfo
        puts "Selected IPv4 address: #{ipv4_address}"
        uri.host = ipv4_address
        ENV['DATABASE_URL'] = uri.to_s
        puts "✓ Forced IPv4 database connection: #{ipv4_address}"
      else
        puts "⚠ Warning: No IPv4 addresses found for #{uri.host}"
      end
    else
      puts "Database host is already an IP address: #{uri.host}"
    end
  rescue => e
    warn "✗ Could not force IPv4 for database: #{e.message}"
    warn "   #{e.class}: #{e.message}"
    warn e.backtrace.first(5).join("\n   ")
  end
end
