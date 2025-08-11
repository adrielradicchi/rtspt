defmodule RtsptWeb.StocksGenerators.PriceGenerator do
  use GenServer
  require Logger

  @default_symbols ~w(AAPL TSLA MSFT AMZN)

  def subscribe_symbol(symbol) do
    GenServer.cast(__MODULE__, {:add_symbol, String.upcase(symbol)})
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    schedule_tick()
    {:ok, @default_symbols}
  end

  @impl true
  def handle_cast({:add_symbol, symbol}, state) do
    new_state =
      case symbol in state do
        true -> state
        false ->
          Logger.debug("Add a new symbol: #{symbol}")
          [symbol | state]
      end

    {:noreply, new_state}
  end

  @impl true
  def handle_info(:tick, symbols) do
    Enum.each(symbols, fn symbol  ->
      price = :rand.uniform(1000) |> Kernel./(100)
      # Logger.debug("Generated price for #{symbol}: $#{price}")

      Phoenix.PubSub.broadcast(
        Rtspt.PubSub,
        "stock:#{symbol}",
        {:stock_update, symbol, price}
      )
    end)

    schedule_tick()
    {:noreply, symbols}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, 2_000)
  end
end
