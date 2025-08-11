defmodule Rtspt.Repo do
  use Ecto.Repo,
    otp_app: :rtspt,
    adapter: Ecto.Adapters.Postgres
end
