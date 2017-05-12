# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rplace2,
  ecto_repos: [Rplace2.Repo]

# Configures the endpoint
config :rplace2, Rplace2.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "suGN8bXNQxBqWBOu3Z1aYVELtWJi7GDbXAkUh3zAEs4KSYdG0YbEqiat68wA2g1s",
  render_errors: [view: Rplace2.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rplace2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
