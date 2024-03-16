defmodule HottestCityTest do
  use ExUnit.Case
  doctest HottestCity

  test "greets the world" do
    assert HottestCity.hello() == :world
  end
end
