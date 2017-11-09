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

# Configure mailing
config :ev2, Ev2.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SES_SERVER"),
  port: System.get_env("SES_PORT"),
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :always, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

# Configure S3
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: "eu-west-1",
  host: "#{System.get_env("BUCKET_NAME")}.s3.amazonaws.com",
  s3: [
   scheme: "https://",
   host: "#{System.get_env("BUCKET_NAME")}.s3.amazonaws.com",
   region: "eu-west-1"
  ]

# docusign
config :ev2, Ev2.Sign,
  username: System.get_env("SANDBOX_DOCUSIGN_USERNAME"),
  password: System.get_env("SANDBOX_DOCUSIGN_PASSWORD"),
  integrator_key: System.get_env("DOCUSIGN_INTEGRATOR_KEY"),
  url: "https://demo.docusign.net/restapi/v2/login_information"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
