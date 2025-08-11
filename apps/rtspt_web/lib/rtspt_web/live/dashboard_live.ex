defmodule RtsptWeb.DashboardLive do
  use RtsptWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:form, to_form(%{"symbol" => ""}, as: :stock))
      |> assign(:subscribed_symbols, MapSet.new())
      |> assign(:prices, %{})
    }
  end

  @impl true
  def handle_event("subscribe", %{"stock" => %{"symbol" => symbol}}, socket) do
    symbol = String.upcase(symbol)
    RtsptWeb.StocksGenerators.PriceGenerator.subscribe_symbol(symbol)
    if connected?(socket), do: Phoenix.PubSub.subscribe(Rtspt.PubSub, "stock:#{symbol}")

    {:noreply,
      socket
      |> assign(:form, to_form(%{"symbol" => ""}, as: :stock))
      |> update(:subscribed_symbols, &MapSet.put(&1, symbol))
    }
  end

  @impl true
  def handle_event("unsubscribe", %{"symbol" => symbol}, socket) do
    symbol = String.upcase(symbol)
    if connected?(socket), do: Phoenix.PubSub.unsubscribe(Rtspt.PubSub, "stock:#{symbol}")

    {:noreply,
      socket
      |> update(:subscribed_symbols, &MapSet.delete(&1, symbol))
      |> update(:prices, &Map.delete(&1, symbol))
    }
  end

  @impl true
  def handle_info({:stock_update, symbol, price}, socket) do
    if MapSet.member?(socket.assigns.subscribed_symbols, symbol) do
      {:noreply, update(socket, :prices, &Map.put(&1, symbol, price))}
    else
      {:noreply, socket}
    end
  end
end
