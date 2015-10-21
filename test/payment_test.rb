require './test/route_test.rb'

class PaymentTest < RouteTest
#   def setup
#     get '/'
#     session[:order] = {:items => {"prod_78NZR6NzHYSvOv" => "3", "prod_7Ab8nEB9FGA7wv" => "3"}}
#     puts "session: " + session.to_s
#   end
  
#   def test_payment_post
#     env "rack.session", {:order => {:items => {"prod_78NZR6NzHYSvOv" => "3", "prod_7Ab8nEB9FGA7wv" => "3"}}}
#     post '/payment', {"phone" => "3125551234"}
#     puts "session: " + env.to_s
#     assert last_response.ok?
#   end

#   def test_order_session_insertion
#     order_items = {"prod_78NZR6NzHYSvOv" => "3", "prod_7Ab8nEB9FGA7wv" => "3"}
#     post '/order', order_items
#     assert_equal order_items, last_request.env['rack.session'][:items]
#   end
end