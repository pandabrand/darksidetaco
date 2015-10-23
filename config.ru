require './app'
require 'sprockets'

taco = Darksidetaco::App
run taco

if ENV['RACK_ENV'] == 'production'
	  sessioned = Rack::Session::Pool.new(taco,
      :session_secret => ENV['SESSION_SECRET']
	  :domain => 'darksidetaco.com',
	  :expire_after => 2592000
  )
#   Rack::Handler::WEBrick.run sessioned
end