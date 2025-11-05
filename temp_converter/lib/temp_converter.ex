defmodule TempConverter do
  @moduledoc """
  Documentation for `TempConverter`.
  """

  def convert_temp(temp, from_unit, to_unit) when is_number(temp) do
    cond do
      {from_unit, to_unit} == {:celcius, :fahrenheit} -> celcius_to_fahrenheit(temp)
      {from_unit, to_unit} == {:fahrenheit, :celcius} -> fahrenheit_to_celsius(temp)
      true -> {:error, "Unsupported unit convertion"}
    end
  end

  defp celcius_to_fahrenheit(temp) do
    if temp < -273.15, do: {:error, "Below absolute zero"}, else: temp * 9 / 5 + 32
  end

  defp fahrenheit_to_celsius(temp) do
    case temp do
      t when t < -459.67 -> {:error, "below absolute zero"}
      t -> (t - 32) * 5 / 9
    end
  end
end
