defmodule InventoryManager do
  # def get_product(inventory, name) do
  #   Enum.find(inventory, fn product -> product.name == name end)
  # end
  # recurions version
  def get_product(inventory, name) do
    find_product(inventory, name)
  end

  defp find_product([], _name), do: nil
  defp find_product([%Product{name: name} = product | tail], name), do: product
  defp find_product([_product | rest_inventory], name), do: find_product(rest_inventory, name)

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
