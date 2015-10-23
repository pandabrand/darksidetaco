require './app'
require 'sprockets'

taco = Darksidetaco::App
run taco

if ENV['RACK_ENV'] == 'production'
  use Rack::Session::Cookie,
    :key => 'rack.session',
    :expire_after => 60.minutes, # In seconds
    :secret => ENV['SESSION_SECRET']
end