defmodule Mix.Tasks.Ev2.Seed do

  @moduledoc """
    This file handles seeding of data in all environments.
    It is a mix task so can be run from terminal with ``
    It is a mix task so can be run from terminal with `$ mix Ev2.Seed`

    Seed data is split into default and mock.

    Default data needs to be added to the DB regardless of environment
    and includes Permissions, Roles, Job titles and Descriptions.

    Mock data is for testing the application in development or in
    the staging environment
  """

  use Mix.Task
  # alias Ev2.Repo
  alias Ev2.Seed.Accounts
  # import Ecto
  require Logger

  # required function for a Mix.Task
  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  # seed dev environment
  def seed(:dev) do
    Logger.info "seeding in dev environment"

    # seed default data
    default_seed()

    # seed mock data
    # Accounts
    # Production
    # Onboard
  end

  def seed(:prod) do
    Logger.info "seeding in prod environment"

    # seed default data
    default_seed()

    # seed super admin users
    # Ev2.Accounts.Seed.super_admins()
  end

  def default_seed do
    Logger.info "runing default seeds"
    # seed Accounts
    Accounts.seed_all()
    # seed Onboard data
  end
end
