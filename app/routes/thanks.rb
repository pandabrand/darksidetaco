module Darksidetaco
  module Routes
    class Thanks < Base
      post '/thanks' do
      	
		customer = Stripe::Customer.create(
		  :email => params[:stripeEmail],
		  :card  => params[:stripeToken]
		)

		items = Array.new
		session[:order_items].each{|product,qty| items.push({:type => 'sku',:parent => product.skus.data.first.id, :quantity => qty})}
		@order = Stripe::Order.create(
		  :currency => 'usd',
		  :customer => customer.id,
		  :items => items,
		  :shipping => {
			:name => params[:stripeShippingName],
			:phone => session[:phone],
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