defmodule Profilo.Repo do
  use Ecto.Repo,
    otp_app: :profilo,
    adapter: Ecto.Adapters.Postgres
end
