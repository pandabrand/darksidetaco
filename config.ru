require './app'
require 'sprockets'
require 'rack/moneta_cookies'

taco = Darksidetaco::App
run taco

if ENV['RACK_ENV'] == 'production'
#   use Rack::Session::Cookie,
#     :key => 'rack.session',
#     :expire_after => 60.minutes, # In seconds
#     :secret => ENV['SESSION_SECRET']
puts ENV['URL']
#   use Rack::MonetaCookies, domain: 'example.com', path: '/'
  use Rack::MonetaCookies, path: '/'
	run lambda { |env|
	  req = Rack::Request.new(env)
	  req.cookies #=> is now a Moneta store!
	  env['rack.request.cookie_hash'] #=> is now a Moneta store!
	  req.cookies['key'] #=> retrieves 'key'
	  req.cookies['key'] = 'value' #=> sets 'key'
	  req.cookies.delete('key') #=> removes 'key'
	  [200, {}, []]
	}
end