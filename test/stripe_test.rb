require 'minitest/autorun'
require 'stripe'
require './app.rb'

class StripeTest < MiniTest::Test
  def setup
    Stripe.api_key = ENV['SECRET_KEY']
  end

  def test_products_are_available
    products = Stripe::Product.all
    assert_equal 2, products.data.size
  end
  
  def test_get_product_name
    products = Stripe::Product.all
    refute_nil products.data.first.name
  end
  
  def test_product_quantity
    products = Stripe::Product.all
    assert_equal 25, products.data.first.skus.data.first.inventory.quantity
  end
  
  def test_product_sku
    product = Stripe::Product.retrieve("prod_78NXCykA4x1Ewe")
    assert_equal "sku_78NYRlVxAkrUiJ", product.skus.data.first.id
  end
end