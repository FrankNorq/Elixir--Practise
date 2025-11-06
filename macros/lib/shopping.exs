defmodule Shopping do
  defmacro cart({:+, _, [cart, item]}) do
    quote do
      cart = unquote(cart)
      item = unquote(item)
      new_cart = [item | cart]
      IO.puts("Added #{item} to the cart, new cart: #{inspect(new_cart)}")
      new_cart
    end
  end

  defmacro cart({:-, _, [cart, item]}) do
    quote do
      cart = unquote(cart)
      item = unquote(item)
      new_cart = List.delete(cart, item)
      IO.puts("deleted #{item} to the cart, new cart: #{inspect(new_cart)}")
      new_cart
    end
  end
end
