# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :map_route_phoenix,
  ecto_repos: [MapRoutePhoenix.Repo]

# Configures the endpoint
config :map_route_phoenix, MapRoutePhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1WGwWpNaAGHVFANg4RLl8VFwEcccx13kRTIsFgAFWU2u+LKbN2Y1iUV1X6pO0D/X",
  render_errors: [view: MapRoutePhoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MapRoutePhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures GeoIP
config :geoip,
  provider: :ipinfo,
  api_key: "<Put your API key here>"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
