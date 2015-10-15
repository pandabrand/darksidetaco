module Darksidetaco
  module Routes
    class Order < Base
      post '/order' do
        items = params.find_all { |item| item[1].to_i > 0 }
        items.each{|p| puts p[1]}
        session[:items] = items
      	erb :location
      end
    end
  end
end