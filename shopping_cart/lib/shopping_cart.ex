defmodule ShoppingCart do
  @moduledoc """
  Documentation for `ShoppingCart`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ShoppingCart.hello()
      :world

  """
  def add_item(cart, item = %{name: _, price: _}) do
    [item | cart]
  end

  def remove_item(cart, item = %{name: _, price: _}) do
    List.delete(cart, item)
  end

  def remove_firt([_head | tail]) do
    tail
  end

  def get_first(cart) do
    List.first(cart)
  end

  def get_last(cart) do
    List.last(cart)
  end

  def get_total(cart, discount \\ 0) do
    Enum.reduce(cart, 0, fn item, total -> item.price + total end)
    |> subtract_discount(discount)
  end

  defp subtract_discount(total, discount) do
    total * ((100 - discount) / 100)
  end
end
