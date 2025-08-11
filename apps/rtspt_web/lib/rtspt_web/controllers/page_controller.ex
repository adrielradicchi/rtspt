defmodule RtsptWeb.PageController do
  use RtsptWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
