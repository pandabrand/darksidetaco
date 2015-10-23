require './app'
require 'sprockets'

taco = Darksidetaco::App
run taco

if ENV['RACK_ENV'] == 'production'
  use Rack::Session::Cookie,
    :key => 'rack.session',
    :domain => 'darksidetaco.com',
    :path => '/',
    :expire_after => 2592000, # In seconds
    :secret => ENV['SESSION_SECRET']
end