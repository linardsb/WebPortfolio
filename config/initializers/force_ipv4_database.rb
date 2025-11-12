# Force IPv4 connections to PostgreSQL to avoid Render's IPv6 connectivity issues
if Rails.env.production? && ENV['DATABASE_URL'].present?
  require 'uri'
  require 'resolv'

  begin
    uri = URI.parse(ENV['DATABASE_URL'])

    if uri.host
      # Resolve hostname to IPv4 address only
      ipv4_address = Resolv.getaddress(uri.host).to_s rescue nil

      # Check if we got an IPv6 address (contains colons)
      if ipv4_address && ipv4_address.include?(':')
        # Try to get IPv4 specifically
        resolver = Resolv::DNS.new
        ipv4_records = resolver.getresources(uri.host, Resolv::DNS::Resource::IN::A)
        ipv4_address = ipv4_records.first&.address&.to_s if ipv4_records.any?
      end

      if ipv4_address && !ipv4_address.include?(':')
        # Replace hostname with IPv4 address
        uri.host = ipv4_address
        ENV['DATABASE_URL'] = uri.to_s
        Rails.logger.info "Forced IPv4 database connection: #{ipv4_address}"
      end
    end
  rescue => e
    Rails.logger.warn "Could not force IPv4 for database connection: #{e.message}"
  end
end
