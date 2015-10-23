module Darksidetaco
  module Routes
    class Base < Sinatra::Application
      configure do
        set :views, 'app/views'
        set :root, App.root

        disable :method_override
        disable :protection
        disable :static

		set :publishable_key, ENV['PUBLISHABLE_KEY']
		set :secret_key, ENV['SECRET_KEY']
		Stripe.api_key = settings.secret_key
		
        set :erb, escape_html: true,
                  layout_options: {views: 'app/views/layouts'}

        enable :use_code
      end
      session = getSessionStore.load(sessionId)
      
      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor
    end
  end
end