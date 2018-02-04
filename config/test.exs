use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :commodity_game_api, CommodityGameApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :commodity_game_api, CommodityGameApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "commodity_game_api_test",
  pool: Ecto.Adapters.SQL.Sandbox
