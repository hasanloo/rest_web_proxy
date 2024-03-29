# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rest_web_proxy,
  ecto_repos: [RestWebProxy.Repo]

# Configures the endpoint
config :rest_web_proxy, RestWebProxyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WU49bNY1x2oVDzWNi7ifxlsI5rXJfvqlcX1iqQUKoYEHmaADHMXf8iuLiQbA9MSC",
  render_errors: [view: RestWebProxyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: RestWebProxy.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
