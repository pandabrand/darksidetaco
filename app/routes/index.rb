module Darksidetaco
  module Routes
    class Index < Base
      get '/' do
		t = Time.now

		r = Range.new(
		  Time.local(t.year, t.month, t.day, 21),
		  Time.local(t.year, t.month, t.day+1, 2, 30)
		)
      	itslit = false
      	#if settings.production?
      	#  @itslit = t === r
      	#end
      	
	    @products = Stripe::Product.all
        erb :index
      end
      
      
    end
  end
end