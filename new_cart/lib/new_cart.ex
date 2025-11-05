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

      :show ->
        IO.puts("cart: #{inspect(cart)}")
        listen(cart)
    end
  end
end
