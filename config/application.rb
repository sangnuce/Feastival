require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Feastival
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**",
    "*.{rb,yml}")]
    config.active_record.time_zone_aware_types = [:datetime, :time]

    config.generators do |generator|
      generator.test_framework :rspec
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
