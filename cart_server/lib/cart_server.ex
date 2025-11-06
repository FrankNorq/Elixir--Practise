defmodule CartServer do
  use GenServer

  ## client
  def start_link(name) do
    IO.puts("Cart Server starting…")
    GenServer.start_link(CartServer, %{}, name: name)
  end

  def start_child(name) when is_atom(name) do
    DynamicSupervisor.start_child(:dynamic_cart_sup, {CartServer, name})
  end

  def child_spec(name) do
    %{
      id: __MODULE__,
      restart: :permanent,
      shutdown: 5000,
      start: {__MODULE__, :start_link, [name]},
      type: :worker
    }
  end

  def cart_total(cart_id) when is_atom(cart_id), do: GenServer.call(cart_id, :total)

  def add_item(cart_id, item) when is_atom(cart_id),
    do: GenServer.cast(cart_id, {:add_item, item})

  ## callbacks
  @impl true
  def init(:ok) do
    {:ok, %{cart: [], timer_ref: nil}}
  end

  @impl true
  def handle_call(:total, _from, state) do
    total =
      Enum.reduce(state.cart, 0.0, fn item, acc -> acc + item[:price] * item[:qty] end)

    {:reply, total, state}
  end

  @impl true
  def handle_cast({:add_item, item}, state) do
    new_state =
      state
      |> Map.update!(:cart, fn cart -> [item | cart] end)
      |> reminder_timer()

    {:noreply, new_state}
  end

  @impl true
  def handle_info(:reminder, state) do
    IO.puts("Hey don't forget your cart")
    {:noreply, %{state | timer_ref: nil}}
  end

  defp reminder_timer(state) do
    case state.timer_ref do
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
