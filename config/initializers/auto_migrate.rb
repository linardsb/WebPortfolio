# Auto-run migrations on startup in production
# This is needed because Render free tier doesn't support release commands
if Rails.env.production?
  begin
    ActiveRecord::Base.connection
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    Rails.logger.info "Running pending migrations..."
    ActiveRecord::MigrationContext.new(Rails.root.join('db', 'migrate').to_s).migrate
    Rails.logger.info "Migrations complete!"
  rescue StandardError => e
    Rails.logger.warn "Migration check failed: #{e.message}"
  end
end
