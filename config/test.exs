use Mix.Config

# Configure your database
config :review_api, ReviewApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "review_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :review_api, ReviewApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
