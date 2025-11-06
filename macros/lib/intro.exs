defmodule Intro do
  defmacro display_value(value) do
    quote do
      value = unquote(value)
      IO.puts("This is the value: #{value}")
      value
    end
  end
end
