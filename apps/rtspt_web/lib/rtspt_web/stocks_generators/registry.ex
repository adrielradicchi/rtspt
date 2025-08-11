defmodule RtsptWeb.StocksGenerators.Registry do
  @moduledoc "Registry for tracking stock subscribers by symbol."
  use Supervisor

  def start_link(_opts) do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {Registry, keys: :unique, name:  RtsptWeb.StocksGenerators.Registry}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
