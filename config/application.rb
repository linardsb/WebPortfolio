require_relative 'boot'

# Fix for Rails 6.0 + Ruby 3.1 Logger compatibility
require 'logger'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "dotenv-rails"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebPortfolio
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.generators.system_tests = nil
    config.eager_load_paths << "#{Rails.root}/lib"
    # Rails will use ENV["SECRET_KEY_BASE"] automatically
  end
end
