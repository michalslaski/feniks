defmodule FeniksTest do
  use ExUnit.Case
  doctest Feniks

  test "greets the world" do
    assert Feniks.hello() == :world
  end
end
