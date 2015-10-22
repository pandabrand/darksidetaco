module Darksidetaco
  module Routes
    class Index < Base
      get '/' do
      	@open_date = next_open_date
      	time_open = ENV['TIME_OPEN'].split(",")
      	@lift_gate = ENV['LIFT_GATE'] === 'true'
      	puts @lift_gate
      	@show_order_button = is_store_open @open_date,time_open,ENV['TIME_CLOSE'].split(",")
  	    @next_opening = Time.zone.local(next_open_date.year, next_open_date.month, next_open_date.day, time_open[0].to_i, time_open[1].to_i, time_open[2].to_i)
	    @products = Stripe::Product.all
        erb :index
      end
      
      
    end
  end
end