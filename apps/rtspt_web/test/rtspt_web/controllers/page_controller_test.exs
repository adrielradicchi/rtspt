defmodule RtsptWeb.PageControllerTest do
  use RtsptWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Welcome to StockFeed!"
  end
end
