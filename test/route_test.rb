require 'minitest/autorun'
require 'rack/test'
require 'stripe'
require './app.rb'

class RouteTest < MiniTest::Test 
  include Rack::Test::Methods
  
  def app
    Darksidetaco::App.new
  end
  
  def session 
    last_request.env['rack.session'] 
  end
  
end