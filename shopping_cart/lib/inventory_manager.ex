defmodule InventoryManager do
  def get_product(inventory, name) do
    Enum.find(inventory, fn product -> product.name == name end)
  end

  def update_inventory(inventory, name, amount) do
    Enum.map(inventory, fn product ->
      if product.name == name do
        %{product | quantity: product.quantity - amount}
      else
        product
      end
    end)
  end

  def restock(inventory) do
    Enum.map(inventory, fn product ->
      if product.quantity < product.reorder_level do
        %{product | quantity: product.quantity + product.reorder_amount}
      else
        product
      end
    end)
  end
end
