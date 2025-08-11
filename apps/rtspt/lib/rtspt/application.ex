defmodule Rtspt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Rtspt.Repo,
      {DNSCluster, query: Application.get_env(:rtspt, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Rtspt.PubSub}
      # Start a worker by calling: Rtspt.Worker.start_link(arg)
      # {Rtspt.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Rtspt.Supervisor)
  end
end
