module Darksidetaco
  module Routes
    class Payment < Base
      post '/payment' do
        order = session[:order]
        order[:phone] = params[:phone]
		@order_items = Hash.new
		order[:items].each{|id, qty| @order_items[Stripe::Product.retrieve(id)] = qty}
		@description = Array.new
		@order_items.each{|item, qty| @description.push(item.name + ": "  + qty)}
		@total = @order_items.keys.map{|product| product.skus.data.first.price * @order_items[product].to_i}.inject(0, &:+)
		order[:order_items] = @order_items
		session[:order] = order
      	erb :payment
      end
    end
  end
end