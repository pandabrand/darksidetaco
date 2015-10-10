module Darksidetaco
  module Models
    class Order
        include ActiveModel::Validations

      attr_accessor :first, :last, :add_one, :add_two, :zip, :phone, :email
      validates_presence_of :first, :last, :add_one, :zip, :phone, :email
    end
  end
end
