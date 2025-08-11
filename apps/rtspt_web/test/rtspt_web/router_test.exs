defmodule RtsptWeb.RouterTest do
  use RtsptWeb.ConnCase, async: true

  test "GET / returns 200 and renders home page", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Welcome"
  end

  test "GET /dashboard redirects if not authenticated", %{conn: conn} do
    conn = get(conn, ~p"/dashboard")
    assert redirected_to(conn) =~ "/users/log-in"
  end

  test "GET /users/register renders registration page", %{conn: conn} do
    conn = get(conn, ~p"/users/register")
    assert html_response(conn, 200) =~ "Register"
  end

  test "GET /users/log-in renders login page", %{conn: conn} do
    conn = get(conn, ~p"/users/log-in")
    assert html_response(conn, 200) =~ "Email"
  end
end
