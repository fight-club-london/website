use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ev2, Ev2Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ev2, Ev2.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ev2_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure password hashing
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1


# Configure Bamboo
config :ev2, Ev2.Mailer,
  adapter: Bamboo.TestAdapter
