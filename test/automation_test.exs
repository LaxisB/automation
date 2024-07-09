defmodule AutomationTest do
  use ExUnit.Case
  doctest Automation

  test "greets the world" do
    assert Automation.hello() == :world
  end
end
