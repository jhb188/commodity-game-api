# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :commodity_game_api,
  ecto_repos: [CommodityGameApi.Repo]

# Configures the endpoint
config :commodity_game_api, CommodityGameApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Te2miAs49p+qrdcUG4CMWcQg05Gr5Sauc1RAcHtaPHR56V18x1dFkBCgkuQIaHJE",
  render_errors: [view: CommodityGameApi.ErrorView, accepts: ~w(json)],
  pubsub: [name: CommodityGameApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "CommodityGameApi",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: CommodityGameApi.GuardianSerializer,
  secret_key: "F2vJUUR/Id9TZer8jETLPPAtRR6g+MOh/cicgpCGcUnqhalWlhiS8/HtRXOrI6w0"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
