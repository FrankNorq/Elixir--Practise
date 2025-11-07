defmodule DiscountDslTest do
  use ExUnit.Case
  doctest DiscountDsl

  test "Ensure the Module Loads" do
    assert Code.ensure_loaded(DiscountDsl)
  end

  # 1. Apply a discount to a product if the condition met.
  test "single discount is applied correctrly" do
    product = %{price: 60, category: "Toys"}
    discounted_product = Discounts.apply_discounts(product)
    assert discounted_product.free_shipping == true
    assert discounted_product.price == 60
  end

  # 2 apply multiple discounts if the condition is met
  test "Multiple discounts are applied in order" do
    product = %{price: 200, category: "Electronics"}
    discounted_product = Discounts.apply_discounts(product)
    assert discounted_product.free_shipping == true
    assert discounted_product.price == 171
  end

  # 3
  test "No discount if nothing is met" do
    product = %{price: 30, category: "Toys"}
    discounted_product = Discounts.apply_discounts(product)
    assert discounted_product == product
  end

  # 4
  test "Checking edge case to make sure no discount is applied if product is 100dollars" do
    product = %{price: 100, category: "Toys"}
    discounted_product = Discounts.apply_discounts(product)
    assert discounted_product.price == 100
    assert discounted_product.free_shipping == true
  end

  # 5
end
