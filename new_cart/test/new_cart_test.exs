defmodule NewCartTest do
  use ExUnit.Case
  doctest NewCart

  test "greets the world" do
    assert NewCart.hello() == :world
  end
end
