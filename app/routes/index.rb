module Darksidetaco
  module Routes
    class Index < Base
      get '/' do
		t = Time.now

		r = Range.new(
		  Time.local(t.year, t.month, t.day, 21),
		  Time.local(t.year, t.month, t.day+1, 2, 30)
		)
      	@itslit = false
      	#if settings.production?
      	#  @itslit = t === r
      	#end
      	
        erb :index
      end
      
      post '/order' do
      	@steak = params['steak']
      	@chicken = params['chicken']
      	erb :location
      end
      
      post '/payment' do
		@phone = params[:phone]
      	@steak = params[:steak]
      	@chicken = params[:chicken]
      	@chicken_cost = @chicken.to_i * 6
      	@steak_cost = @steak.to_i * 6
      	@total_tacos = @steak.to_i + @chicken.to_i
      	@cost_display = @total_tacos*6
      	@total_cost = @total_tacos * 6 * 100
      	@description = "chicken tacos: #{@chicken} and steak tacos: #{@steak}"
      	erb :payment
      end
      
      post '/thanks' do
		@phone = params[:phone]
      	@steak = params[:steak]
      	@chicken = params[:chicken]
      	@chicken_qty = @chicken.to_i
      	@steak_qty = @steak.to_i
      	@total_tacos = @steak_qty + @chicken_qty
      	@cost_display = @total_tacos*6
      	@total_cost = @total_tacos * 6 * 100
      	@description = "chicken tacos: #{@chicken} and steak tacos: #{@steak}"
		customer = Stripe::Customer.create(
		  :email => params[:stripeEmail],
		  :card  => params[:stripeToken]
		)

		charge = Stripe::Charge.create(
		  :amount      => @total_cost,
		  #:description => @description,
		  :currency    => 'usd',
		  :customer    => customer.id
		)
		
		if @chicken_qty > 0 && @steak_qty > 0
		  @order = Stripe::Order.create(
			:currency => 'usd',
			:customer => customer.id,
			:items => [
			  {
				:type => 'sku',
				:parent => ENV['CHICKEN'],
				:quantity => @chicken
			  },
			  {
				:type => 'sku',
				:parent => ENV['STEAK'],
				:quantity => @steak
			  }
			],
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
		elsif @chicken_qty > 0 && @steak_qty == 0
		  @order = Stripe::Order.create(
			:currency => 'usd',
			:customer => customer.id,
			:items => [
			  {
				:type => 'sku',
				:parent => ENV['CHICKEN'],
				:quantity => @chicken
			  }
			],
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
		elsif @chicken_qty == 0 && @steak_qty > 0
		  @order = Stripe::Order.create(
			:currency => 'usd',
			:customer => customer.id,
			:items => [
			  {
				:type => 'sku',
				:parent => ENV['STEAK'],
				:quantity => @steak
			  }
			],
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
        end		
        
        
		erb :thanks
      
      end
    end
  end
end