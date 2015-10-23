require './app'
require 'sprockets'
require 'rack/session/moneta'

taco = Darksidetaco::App
run taco

if ENV['RACK_ENV'] == 'production'
#   use Rack::Session::Cookie,
#     :key => 'rack.session',
#     :expire_after => 60.minutes, # In seconds
#     :secret => ENV['SESSION_SECRET']

  # Use only the adapter name
#   use Rack::Session::Moneta, store: :Redis

  # Use Moneta.new
#   use Rack::Session::Moneta, store: Moneta.new(:Memory, expires: true)

  # Set rack options
#   use Rack::Session::Moneta, key: 'rack.session',
#   domain: ENV['DOMAIN'],
#   path: '/',
#   expire_after: 2592000,
#   store: Moneta.new(:Memory, expires: true)

  # Use the Moneta builder
#   use Rack::Session::Moneta do
# 	use :Expires
# 	adapter :Memory
#   end
end