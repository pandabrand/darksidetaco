module Darksidetaco
  module Helpers
    def make_price_from_product_and_quantity(product, qty)
      return Money.new(product.skus.data.first.price * qty.to_i, product.skus.data.first.currency)
    end
    
    def is_store_open
	  open_dates = ENV['DATES_OPEN'].split(",")
	  today = Date.today
	  open_date = open_dates.find { |date| Date.parse(date) == today }
	  unless open_date.nil?
		open_time = DateTime.new(open_date.year, open_date.month, open_date.day, 21, 0, 0, '-6')
		closing = DateTime.new(open_date.year, open_date.month, open_date.day+1, 2, 30, 0, '-6')
		return today.to_datetime > open_time && today.to_datetime < closing
	  end
	  return false
    end
    
    def next_open_date
	  open_dates = ENV['DATES_OPEN'].split(",")
	  today = Date.today
	  open_date = open_dates.find { |date| Date.parse(date) >= today }
	end
  end
end