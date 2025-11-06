defmodule NewCart do
  @moduledoc """
  Documentation for `NewCart`.
  """

  def start_cart do
    spawn(fn -> listen([]) end)
  end

  defp listen(cart) do
    receive do
      {:add_item, item_name} ->
        new_cart = [item_name | cart]
        IO.puts("item added to cart: #{item_name}")
        listen(new_cart)

      {:remove_item, item_name} ->
        if item_name in cart do
          new_cart = List.delete(cart, item_name)
          IO.puts("Item removed: #{item_name}")
          listen(new_cart)
        else
          IO.puts("item not in cart")
          listen(cart)
        end

      :show ->
        IO.puts("cart: #{inspect(cart)}")
        listen(cart)
    end
  end
end
