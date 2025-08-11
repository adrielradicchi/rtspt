defmodule RtsptWeb.StocksChannel do
  use Phoenix.Channel

  def join("stock:" <> symbol, _params, socket) do
    Phoenix.PubSub.subscribe(Rtspt.PubSub, "stock:#{symbol}")
    {:ok, socket}
  end

  def handle_info({:stock_update, symbol, price}, socket) do
    push(socket, "stock_update", %{symbol: symbol, price: price})
    {:noreply, socket}
  end
end
