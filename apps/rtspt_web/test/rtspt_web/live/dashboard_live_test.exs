defmodule RtsptWeb.DashboardLiveTest do
  use RtsptWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rtspt.AccountsFixtures

  setup %{conn: conn} do
    users = users_fixture()
    %{conn: log_in_users(conn, users), users: users}
  end

  test "user can subscribe and receive price updates for a new symbol", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/dashboard")

    symbol = "TESTSYM"

    view
    |> form("#subscribe-form", stock: %{symbol: symbol})
    |> render_submit()

    Phoenix.PubSub.subscribe(Rtspt.PubSub, "stock:#{symbol}")
    RtsptWeb.StocksGenerators.PriceGenerator.subscribe_symbol(symbol)

    # Process.sleep(2100)
    send(view.pid, {:stock_update, symbol, 123.45})

    assert render(view) =~ symbol
    assert render(view) =~ "123.45"
  end

  test "user can unsubscribe from a symbol", %{conn: conn} do
   {:ok, view, _html} = live(conn, ~p"/dashboard")
    symbol = "UNSUB"

    view
    |> form("#subscribe-form", stock: %{symbol: symbol})
    |> render_submit()

    Phoenix.PubSub.subscribe(Rtspt.PubSub, "stock:#{symbol}")
    RtsptWeb.StocksGenerators.PriceGenerator.subscribe_symbol(symbol)

    # Process.sleep(2100)
    send(view.pid, {:stock_update, symbol, 99.99})

    assert render(view) =~ symbol
    assert render(view) =~ "99.99"

    view
    |> element("#unsubscribe-#{symbol}")
    |> render_click()
    refute render(view) =~ "99.99"
  end
end
