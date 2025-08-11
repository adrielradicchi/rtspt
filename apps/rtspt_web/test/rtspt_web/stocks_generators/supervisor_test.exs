defmodule RtsptWeb.StocksGenerators.SupervisorTest do
  use ExUnit.Case, async: true

  test "starts child processes" do
    {:error, {:already_started, sup_pid}} = start_supervised(RtsptWeb.StocksGenerators.Supervisor)
    children = Supervisor.which_children(sup_pid)
    assert Enum.any?(children, fn {_, pid, _, _} -> is_pid(pid) end)
    assert Enum.any?(children, fn {mod, _, _, _} -> mod == RtsptWeb.StocksGenerators.PriceGenerator end)
    assert Enum.any?(children, fn {mod, _, _, _} -> mod == RtsptWeb.StocksGenerators.Registry end)
  end
end
