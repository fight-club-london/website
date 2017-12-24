defmodule Mix.Tasks.Lfc.SeedMock do

  @moduledoc """
    This file handles seeding mock data.
    It is a mix task so can be run from terminal with `$ mix Lfc.SeedMock`

    Mock data is for testing the application in development or in
    the staging environment. The task is run by review apps in the postdeploy
    script in the `app.json` file
  """

  use Mix.Task
  require Logger

  # required function for a Mix.Task
  def run(_) do
    Mix.Task.run "app.start", []
    seed_mock()
  end

  @doc """
  this function should never be run on production
  but add additional check that this is a staging app or review app
  or in development environment
  """
  def seed_mock do
    is_dev? = Application.get_env(lfc, :env) == :dev
    is_staging? = Application.get_env(lfc, :IS_STAGING)
    if is_staging? || is_dev? do
      Logger.info "Seeding mock data"
    end
  end
end
