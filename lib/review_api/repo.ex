defmodule ReviewApi.Repo do
  use Ecto.Repo,
    otp_app: :review_api,
    adapter: Ecto.Adapters.Postgres
end
