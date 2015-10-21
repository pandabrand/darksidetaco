require './test/route_test.rb'

class OrderTest < RouteTest
  def test_order_post
    post '/order', {"prod_78NZR6NzHYSvOv" => "3", "prod_7Ab8nEB9FGA7wv" => "3"}
    assert last_response.ok?
  end

  def test_order_session_insertion
    order_items = {"prod_78NZR6NzHYSvOv" => "3", "prod_7Ab8nEB9FGA7wv" => "3"}
    post '/order', order_items
    assert_equal order_items, last_request.env['rack.session'][:order][:items]
  end
end