defmodule Ev2.Seed.Accounts do

  @moduledoc """
    This file provides an API for seeding all account info
    `Ev2.Seed.AccountsData` contains the seed data we always want to seed.
  """

  alias Ev2.Seed
  alias Ev2.Accounts.{Permission, Role}

  # Ev2.Accounts.PermissionAPI

  def add_permissions() do
    seed = list_seed_permissions()
    db = Ev2.Accounts.PermissionAPI.list_permission_names()
    difference = get_difference(seed, db)

    difference
    |> map_from(:name)
    |> insert_list(Permission)
  end

  def add_roles() do
    seed = list_seed_roles()
    db = Ev2.Accounts.RoleAPI.list_role_names()
    difference = get_difference(seed, db)

    difference
    |> map_from(:name)
    |> insert_list(Role)
  end


  @doc """
  Helper functions to insert list of data.

  insert_list(
    [%{name: "can_view_offer"}, ... ],
    Permission
  )
  """
  def insert_list(data, schema) do
    Ev2.Repo.insert_all(schema, data)
  end

  defp get_difference(seed_data, db_data) do
    seed_data -- db_data
  end

  @doc """
  Takes a list of maps or structs and returns just the value
  represented by the `map_key` argument

  list ["some_value_1", ... ]
  map_key :name

  returns [%{name: "some_value_1"}, ... ]
  """
  def map_from(list, map_key) do
    Enum.map(
      list,
      fn(value) -> Map.put(%{}, map_key, value) end
    )
  end


  @doc """
  Returns all seed permissions as a list of strings
  """
  def list_seed_permissions() do
    Seed.AccountsData.permissions
    |> Map.values()
  end


  def list_seed_roles() do
    Seed.AccountsData.roles
    |> Map.keys()
    |> Enum.map(&Atom.to_string/1)
  end

end
