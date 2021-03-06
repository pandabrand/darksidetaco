require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'dotenv'
Dotenv.load

# Require base
require 'sinatra/base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/json'

Dir['lib/**/*.rb'].sort.each { |file| require file }

require 'app/extensions'
require 'app/models'
require 'app/helpers'
require 'app/routes'

require 'stripe'
require 'money'
require 'encrypted_cookie'
require 'date'
require 'active_support/core_ext/time'

module Darksidetaco
  class App < Sinatra::Application
	Time.zone = "America/Chicago"
    configure do
      set :database, lambda {
        ENV['DATABASE_URL'] ||
          "postgres://localhost:5432/darksidetaco_#{environment}"
      }
    end

    configure :development, :staging do
      database.loggers << Logger.new(STDOUT)
    end

    configure :production do
      set :force_ssl, true
      set :root, File.realdirpath(".")
    end

    configure do
      disable :method_override
      disable :static
      
      
      set :erb, escape_html: true

      use Rack::Session::EncryptedCookie,:secret => ENV['SESSION_SECRET'],
          httponly: true,
          path: '/',
          secure: production?,
          expire_after: 60.minutes
      
    end

    use Rack::Deflater
    use Rack::Standards

    use Routes::Static

    unless settings.production?
      use Routes::Assets
    end

    # Other routes:
    # use Routes::Posts
    use Routes::Index
    use Routes::Order
    use Routes::Payment
    use Routes::Thanks
  end
end

include Darksidetaco::Models