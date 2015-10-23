module Darksidetaco
  module Routes
    class Payment < Base
      post '/payment' do
        order = [:session][:order]
        @phone = params[:phone]
        @items = order[:items]
		@order_items = Hash.new
		@items.each{|id, qty| @order_items[Stripe::Product.retrieve(id)] = qty}
		@description = Array.new
		@order_items.each{|item, qty| @description.push(item.name + ": "  + qty)}
		puts "Payment-order_items: " + @order_items.to_s
		@total = @order_items.keys.map{|product| product.skus.data.first.price * @order_items[product].to_i}.inject(0, &:+)
		[:session][:order_items] = @order_items
		[:session][:phone] = @phone
		[:session][:order] = order
      	erb :payment
      end
    end
  end
end