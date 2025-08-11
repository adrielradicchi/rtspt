defmodule Rtspt.StocksTest do
  use ExUnit.Case, async: true

  test "list_symbols returns all available symbols" do
    assert Rtspt.Stocks.list_symbols() == ~w(AAPL TSLA MSFT AMZN)
  end

  test "valid_symbol?/1 returns true for valid symbol" do
    assert Rtspt.Stocks.valid_symbol?("AAPL")
    refute Rtspt.Stocks.valid_symbol?("INVALID")
  end
end
