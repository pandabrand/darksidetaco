module Darksidetaco
  module Routes
    class Thanks < Base
      post '/thanks' do
      	
		customer = Stripe::Customer.create(
		  :email => params[:stripeEmail],
		  :card  => params[:stripeToken]
		)
		
		#remove items not needed
		order_str = params[:order_v]
		puts "order: " + order_str.to_s
		order_hash = Hash[*order_str.split(",")]
		items = Array.new
		order_hash.each{|id, qty| items.push({:type => 'sku', :parent => Stripe::Product.retrieve(id).skus.data.first.id, :quantity => qty})}
# 		session[:order][:order_items].each{|product,qty| items.push({:type => 'sku',:parent => product.skus.data.first.id, :quantity => qty})}
		@order = Stripe::Order.create(
		  :currency => 'usd',
		  :customer => customer.id,
		  :items => items,
		  :metadata => { "notes": params[:notes] },
		  :shipping => {
			:name => params[:stripeShippingName],
			:phone => params[:phone],
			:address => {
			  :line1 => params[:stripeShippingAddressLine1],
			  :city => params[:stripeShippingAddressCity],
			  :postal_code => params[:stripeShippingAddressZip],
			}
		  }
		)
        
        puts @order
        @order.pay :customer => customer.id
		erb :thanks
      
      end
    end
  end
end