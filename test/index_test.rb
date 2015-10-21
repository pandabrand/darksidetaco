require './test/route_test.rb'

class IndexTest < RouteTest 
  def test_index
    get "/"
    assert last_response.ok?
  end
end