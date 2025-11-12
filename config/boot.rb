ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Force IPv4 for database connections on Render
if ENV['RAILS_ENV'] == 'production' && ENV['DATABASE_URL'].present?
  require 'uri'
  require 'resolv'

  begin
    uri = URI.parse(ENV['DATABASE_URL'])
    if uri.host && uri.host !~ /^\d+\.\d+\.\d+\.\d+$/ # Not already an IP
      # Force IPv4 resolution
      resolver = Resolv::DNS.new
      ipv4_records = resolver.getresources(uri.host, Resolv::DNS::Resource::IN::A)

      if ipv4_records.any?
        ipv4_address = ipv4_records.first.address.to_s
        uri.host = ipv4_address
        ENV['DATABASE_URL'] = uri.to_s
        puts "Forced IPv4 database connection: #{ipv4_address}"
      end
    end
  rescue => e
    warn "Could not force IPv4 for database: #{e.message}"
  end
end
