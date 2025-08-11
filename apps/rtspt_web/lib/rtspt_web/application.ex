defmodule RtsptWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RtsptWeb.Telemetry,
      # Start a worker by calling: RtsptWeb.Worker.start_link(arg)
      # {RtsptWeb.Worker, arg},
      RtsptWeb.StocksGenerators.Supervisor,
      # Start to serve requests, typically the last entry
      RtsptWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RtsptWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RtsptWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
