defmodule RtsptWeb.StocksGenerators.PriceGeneratorTest do
  use ExUnit.Case, async: true

  test "generates prices for default symbols" do
    for symbol <- ["AAPL", "TSLA", "MSFT", "AMZN"] do
      Phoenix.PubSub.subscribe(Rtspt.PubSub, "stock:#{symbol}")
    end

    Process.sleep(2100)
    assert_received {:stock_update, symbol, price} when symbol in ["AAPL", "TSLA", "MSFT", "AMZN"] and is_float(price)
  end
end
