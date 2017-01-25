Rails.application.routes.default_url_options[:host] = Rails.env.production? ? "http://hike.desqer.com" : "localhost:3000"
