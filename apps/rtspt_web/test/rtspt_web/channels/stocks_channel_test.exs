defmodule RtsptWeb.StocksChannelTest do
  use RtsptWeb.ChannelCase

  setup do
    user = Rtspt.AccountsFixtures.users_fixture()
    token = Rtspt.Accounts.generate_users_session_token(user)
    {:ok, token: token, user: user}
  end

  test "authenticated user joins and receives updates", %{token: token} do
    {:ok, socket} =
      connect(RtsptWeb.UsersSocket, %{"token" => token})

    {:ok, _, _socket} = subscribe_and_join(socket, "stock:AAPL", %{})
    Phoenix.PubSub.broadcast(Rtspt.PubSub, "stock:AAPL", {:stock_update, "AAPL", 123.45})
    assert_push "stock_update", %{symbol: "AAPL", price: 123.45}
  end

  test "unauthenticated user cannot join" do
    assert :error = connect(RtsptWeb.UsersSocket, %{"token" => "badtoken"})
  end
end
