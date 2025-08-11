defmodule RtsptWeb.UsersSocket do
  use Phoenix.Socket
  alias Rtspt.Accounts

  channel "stock:*", RtsptWeb.StocksChannel

  def connect(%{"token" => token}, socket, _connect_info) do
    case Accounts.get_users_by_session_token(token) do
      nil -> :error
      user -> {:ok, assign(socket, :current_user, user)}
    end
  end

  def id(_socket), do: nil
end
