defmodule DiscountDsl do
  @moduledoc """
  Documentation for `DiscountDsl`.
  """
  defmodule Discount do
    defmacro __using__(_options) do
      quote do
        import unquote(__MODULE__)
        Module.register_attribute(__MODULE__, :discounts, accumulate: true)
        @before_compile unquote(__MODULE__)
      end
    end

    defmacro __before_compile__(_env) do
      quote do
        def apply_discounts(product) do
          Enum.reduce(@discounts, product, fn discount, acc ->
            apply_discount_rule(acc, discount)
          end)
        end

        defp apply_discount_rule(product, {_name, condition_function, action_function}) do
          if(apply(__MODULE__, condition_function, [product])) do
            apply(__MODULE__, action_function, [product])
          else
            product
          end
        end
      end
    end

    defmacro discount(name, condition, action) do
      quote do
        @discounts {unquote(name), unquote(condition), unquote(action)}
      end
    end
  end
end
