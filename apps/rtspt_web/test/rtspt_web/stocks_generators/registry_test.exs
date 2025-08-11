defmodule RtsptWeb.StocksGenerators.RegistryTest do
  use ExUnit.Case, async: true

  test "starts and registers a process" do
    {:ok, _} = Registry.register(RtsptWeb.StocksGenerators.Registry, "SYM1", [])
    assert [{pid, _}] = Registry.lookup(RtsptWeb.StocksGenerators.Registry, "SYM1")
    assert is_pid(pid)
  end
end
