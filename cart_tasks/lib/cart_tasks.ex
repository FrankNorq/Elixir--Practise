defmodule CartTasks do
  @moduledoc """
  Documentation for `CartTasks`.
  """
  def add_item(item_id) do
    task = Task.async(fn -> Inventory.check_inventory(item_id) end)
    update_cart_ui(:loading)
    discount = calculate_promo_discount(item_id)
    apply_discount(discount)
    Task.yield(task, 3000)
    results = Task.await(task)

    case results do
      {:ok, _msg} ->
        update_cart_ui(:success, item_id)

      _ ->
        update_cart_ui(:error, item_id)
    end
  end

  defp update_cart_ui(:loading), do: IO.puts("loading cart...")
  defp update_cart_ui(:success, item_id), do: IO.puts("Item #{item_id} was added to the cart")

  defp update_cart_ui(:error, item_id),
    do: IO.puts("failed to add the #{item_id} item to the cart")

  defp calculate_promo_discount(item_id) do
    :timer.sleep(2000)
    10
  end

  defp apply_discount(discount) do
    IO.puts("Applying a #{discount}% discount to the cart")
  end
end
