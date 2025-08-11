defmodule RtsptWeb.TelemetryTest do
  use ExUnit.Case, async: true

  alias RtsptWeb.Telemetry, as: RtsptWebTelemetry

  test "metrics/0 returns a list of Telemetry metrics" do
    metrics = RtsptWebTelemetry.metrics()
    assert is_list(metrics)
    assert Enum.any?(metrics, fn m -> match?(%Telemetry.Metrics.Summary{}, m) end)
  end

  test "supervisor starts and children are running" do
    {:error, {:already_started, pid}} = start_supervised({RtsptWebTelemetry, []})
    assert Process.alive?(pid)
  end
end
