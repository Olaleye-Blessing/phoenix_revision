defmodule Legend.Repo do
  use Ecto.Repo,
    otp_app: :legend,
    adapter: Ecto.Adapters.Postgres
end
