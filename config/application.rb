require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShedShareApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    #cors configuration
      config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins '*'
          resource '*', :headers => :any, :methods => [:get, :post, :options]
        end
      end
      #autoloads lib folder during production
      config.eager_load_paths << Rails.root.join('lib')

      #autoloads lib folder during development
      config.autoload_paths << Rails.root.join('lib')
      # [...]
    end
end
