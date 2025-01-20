# config/application.rb
require_relative "boot" 

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine" 


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jatei
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone] 
    ## Log to STDOUT because Docker expects all processes to log here. You could
    # then collect logs using journald, syslog or forward them somewhere else.
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch("REDIS_URL") { "redis://redis:6379/1" },
      namespace: "cache"
    }
  
    # Don't generate system test files.
    config.generators.system_tests = nil

    config.middleware.use Rack::Deflater
  end
end