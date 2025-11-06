defmodule CartServer do
  @moduledoc """
  Documentation for `CartServer`.
  """
  use GenServer

  # client
  def start_link do
    GenServer.start_link(CartServer, %{cart: [], timer_pid: nil}, name: :cart_server)
  end

  def cart_total, do: GenServer.call(:cart_server, :total)
  def add_item(item), do: GenServer.cast(:cart_server, {:add_item, item})

  # callbacks
  @impl true
  def handle_call(:total, _from, state) do
    total =
      state.cart
      |> Enum.reduce(0, fn item, acc -> acc + item[:price] * item[:qty] end)

    {:reply, total, state}
  end

  @impl true
  def handle_cast({:add_item, item}, state) do
    new_state =
      %{state | cart: [item | state.cart]}
      |> reminder_timer()

    {:noreply, new_state}
  end

  @impl true
  def handle_info(:reminder, state) do
    IO.puts("Hey dont forget your cart")
    {:noreply, state}
  end

  defp reminder_timer(state) do
    case Map.get(state, :timer_ref) do
      nil ->
        ref = Process.send_after(self(), :reminder, 10_000)
        %{state | timer_ref: ref}

      ref when is_reference(ref) ->
        _ = Process.cancel_timer(ref)
        new_ref = Process.send_after(self(), :reminder, 10_000)
        %{state | timer_ref: new_ref}
    end
  end
end
