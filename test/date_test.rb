require 'minitest/autorun'
require './app.rb'

class DateTest < MiniTest::Test
  def setup 
    @open_dates = "2015-10-10,2015-10-16,2015-10-23,2015-10-24".split(",")
  end
  
  def test_if_date_is_between_range
	today = Date.new(2015,10,16)
    assert_equal true, @open_dates.any? { |date| Date.parse(date) === today }
  end
  
  def test_find_next_open_date
	today = Date.new(2015,10,17)
	open_date = @open_dates.find { |date| Date.parse(date) >= today }
	assert_equal -1, today <=> Date.parse(open_date)
  end
  
  def test_if_time_is_not_range
  	now = DateTime.new(2015,10,15,14,34,34,'-6')
  	date_no_time = Date.parse(@open_dates[1])
  	later = DateTime.new(date_no_time.year, date_no_time.month, date_no_time.day, 21, 0, 0, '-6')
  	assert_equal false, now > later
  end
  
  def test_time_past_range
  	date_no_time = Date.parse(@open_dates.first)
  	now = DateTime.new(date_no_time.year, date_no_time.month, date_no_time.day+1, 3, 0, 0, '-6')
  	closing = DateTime.new(date_no_time.year, date_no_time.month, date_no_time.day+1, 2, 30, 0, '-6')
  	assert_equal false, now < closing
  end
end