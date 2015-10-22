module Darksidetaco
  module Helpers
    def make_price_from_product_and_quantity(product, qty)
      return Money.new(product.skus.data.first.price * qty.to_i, product.skus.data.first.currency)
    end
    
    def is_store_open(open_date, time_open, time_close)
	  today = Time.zone.now
	  opening = Time.zone.local(open_date.year, open_date.month, open_date.day, time_open[0].to_i, time_open[1].to_i, time_open[2].to_i)
	  closing = Time.zone.local(open_date.year, open_date.month, open_date.day+1, time_close[0].to_i, time_close[1].to_i, time_close[2].to_i)
	  return today.to_datetime > opening && today.to_datetime < closing
    end
    
    def next_open_date
	  open_dates = ENV['DATES_OPEN'].split(",")
	  today = Date.today
	  open_date = open_dates.find { |date| Date.parse(date) >= today }
	  return Date.parse(open_date)
	end
  end
end