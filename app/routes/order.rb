module Darksidetaco
  module Routes
    class Order < Base
      post '/order' do
        items = params.find_all { |item| item[1].to_i > 0 }
        order = Hash.new
        @items = Hash[*items.flatten]
      	erb :location
      end
    end
  end
end