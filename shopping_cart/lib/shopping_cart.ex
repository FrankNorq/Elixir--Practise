defmodule ShoppingCart do
  @moduledoc """
  Simple shopping cart.
  """

  @doc """
  Lägg till `amount` av `product_name` i `cart` om det finns i `inventory`.

  Returnerar:
    * `{:ok, new_cart, new_inventory}` vid success
    * `{:error, :product_not_found}` om varan saknas
    * `{:error, :insufficient_stock}` om lagret inte räcker
  """
  def add_item(cart, product_name, amount, inventory) do
    case InventoryManager.get_product(inventory, product_name) do
      nil ->
        {:error, :product_not_found}

      %Product{} = %{quantity: q} = product when q >= amount ->
        item = %{name: product.name, price: product.price, amount: amount}
        new_cart = [item | cart]
        new_inventory = InventoryManager.update_inventory(inventory, product.name, amount)
        {:ok, new_cart, new_inventory}

      _product ->
        {:error, :insufficient_stock}
    end
  end

  def remove_item(cart, item = %{name: _, price: _}) do
    List.delete(cart, item)
  end

  def remove_first([_head | tail]), do: tail
  def remove_first([]), do: []

  def get_first(cart), do: List.first(cart)
  def get_last(cart), do: List.last(cart)

  def get_total(cart, discount \\ 0) do
    subtotal =
      Enum.reduce(cart, 0.0, fn item, total ->
        item.price * item.amount + total
      end)

    apply_discount(subtotal, discount)
  end

  defp apply_discount(total, discount) when is_number(discount) and discount > 0 do
    total * ((100 - discount) / 100)
  end

  defp apply_discount(total, _), do: total
end
