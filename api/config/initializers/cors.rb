# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'dev-jector.com', 'jector2.com', 'jector.com', 'agehatest-jector.com', 'http://setaria.cloud', 'http://staging.setaria.cloud', 'http://dev.setaria.cloud', 'http://neko.setaria.cloud', 'https://setaria.cloud', 'https://neko.setaria.cloud', 'https://staging.setaria.cloud'
    resource '*', headers: :any, expose: ['Retry-After'], methods: [:get, :post, :put, :options, :patch, :delete]
  end
end
