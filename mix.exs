defmodule Lfc.Mixfile do
  use Mix.Project

  def project do
    [
      app: :lfc,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Lfc.Application, []},
      extra_applications: [:logger, :runtime_tools, :comeonin, :bamboo,
                           :redix, :ex_aws, :hackney, :poison, :httpoison,
                           :ex_twilio]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.1.2"},
      {:excoveralls, "~> 0.6.5"},
      {:comeonin, "~> 3.0.2"},
      {:bamboo, "~> 0.7.0"},
      {:bamboo_smtp, "~> 1.2.1"},
      {:mock, "~> 0.3.1", only: :test},
      {:redix, ">= 0.6.1"},
      {:ex_aws, "~> 1.1.5"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.8.6"},
      {:uuid, "~> 1.1.8"},
      {:httpoison, "~> 0.11.2"},
      {:ex_twilio, "~> 0.5.0"},
      {:csv, "~> 2.0.0"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "Lfc.Seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.migrate", "test"]
    ]
  end
end
