Rails.application.config.session_store :redis_store, servers: ENV['REDIS_URL']
