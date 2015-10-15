module Darksidetaco
  module Routes
    class Payment < Base
      post '/payment' do
		session[:phone] = params[:phone]
		@order_items = Hash.new
		session[:items].each{|item| @order_items[Stripe::Product.retrieve(item[0])] = item[1]}
		session[:order_items] = @order_items
		@description = Array.new
		@order_items.each{|item, qty| @description.push(item.name + ": "  + qty)}
		@total = @order_items.keys.map{|product| product.skus.data.first.price * @order_items[product].to_i}.inject(0, &:+)
		session[:total] = @total
      	erb :payment
      end
    end
  end
end