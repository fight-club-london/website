# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ev2,
  ecto_repos: [Ev2.Repo]

# Configures the endpoint
config :ev2, Ev2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oevVJb6s1rUdotvoFbBItcLIKtryrNIwyrOFUbgdtifxL2Ceovd+c/K5wUv8c9MH",
  render_errors: [view: Ev2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ev2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Pre commit
config :pre_commit, commands: ["mix cover"]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
