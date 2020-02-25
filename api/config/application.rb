require File.expand_path('../boot', __FILE__)

require "rails"
require 'dotenv'
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application

    Dotenv.load "#{config.root}/config/.env"

    puts "Environment: #{ENV['RAILS_ENV']}"
    if ENV['RAILS_ENV'] == 'production'
      Dotenv.load "#{config.root}/config/.env.production"
    elsif ENV['RAILS_ENV'] == 'staging'
      Dotenv.load "#{config.root}/config/.env.staging"
    else
      Dotenv.load "#{config.root}/config/.env.development"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::Session::Cookie

    # to auto load lib/ directory
    #
    # NOTE: Rails 5 では production 環境での起動後は autoload が無効になるため、
    # config.autoload_paths の設定を書いても production では読み込まれない。
    # ( https://railsguides.jp/upgrading_ruby_on_rails.html#production環境での起動後は自動読み込みが無効になる )
    #
    # 例えば、lib 配下のプログラムを読み込みたければ、読み込みたいファイルで require_dependency で明示的に require すれば良い。
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/**/ #{config.root}/app/controllers/**/)

    config.cache_store = :redis_store, ENV['REDIS_CACHE_URL'], { expires_in: 72.hours }

    config.time_zone = 'Tokyo'

    config.active_record.default_timezone = :local
  end
end
