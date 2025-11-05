defmodule Product do
  defstruct [
    :name,
    :price,
    quantity: 0,
    reorder_level: 10,
    reorder_amount: 20,
    supplier: %Supplier{}
  ]
end
