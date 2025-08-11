defmodule RtsptWeb.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  If the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use RtsptWeb.ChannelCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import RtsptWeb.ChannelCase

      # The default endpoint for testing
      @endpoint RtsptWeb.Endpoint
    end
  end

  setup tags do
    Rtspt.DataCase.setup_sandbox(tags)
    :ok
  end

  @doc """
  Logs the given `users` into the `conn`.

  It returns an updated `conn`.
  """
  def log_in_users(conn, users, opts \\ []) do
    token = Rtspt.Accounts.generate_users_session_token(users)

    maybe_set_token_authenticated_at(token, opts[:token_authenticated_at])

    conn
    |> Phoenix.ConnTest.init_test_session(%{})
    |> Plug.Conn.put_session(:users_token, token)
  end

  defp maybe_set_token_authenticated_at(_token, nil), do: nil

  defp maybe_set_token_authenticated_at(token, authenticated_at) do
    Rtspt.AccountsFixtures.override_token_authenticated_at(token, authenticated_at)
  end
end
