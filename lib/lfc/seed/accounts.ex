defmodule Lfc.Seed.Accounts do

  @moduledoc """
    This file provides an API for seeding all account info
    `Lfc.Seed.AccountsData` contains the seed data we always want to seed.
  """

  alias Lfc.{Repo, Seed}
  alias Lfc.Accounts.{Permission, PermissionAPI, Role, RoleAPI}
  alias Lfc.Seed.AccountsData

  @doc """
  This function gets called by the outer world. Seeds all default accounts data.
  """
  def seed_all do
    add_permissions()
    add_roles()
    add_role_permissions()
  end

  def add_permissions do
    seed = list_seed_permissions()
    db = PermissionAPI.list_permission_names()
    difference = get_difference(seed, db)

    difference
    |> map_from(:name)
    |> insert_list(Permission)
  end

  def add_roles do
    seed = list_seed_roles()
    db = RoleAPI.list_names()
    difference = get_difference(seed, db)

    difference
    |> map_from(:name)
    |> insert_list(Role)
  end

  @doc """
  Assume roles and permissions have already been added
  This function takes gets the seed roles with permissions.
  It maps through the roles, and calls another function to map through the
  permissions belonging to that role.
  """
  def add_role_permissions do
    # get seed roles with Permissions
    seed = list_seed_roles_with_permissions()

    # map through roles
    Enum.map(seed, &add_permissions_for_role/1)
  end

  @doc """
  This function is called by `add_role_permissions/0`
  """
  defp add_permissions_for_role({role, perms}) do
    # get role from db for link to id
    db_role =
      role
      |> Atom.to_string()
      |> RoleAPI.get_by_name()

    perms
    |> Enum.map(fn seed_perm ->
      # get the permission from db
      db_perm = PermissionAPI.get_by_name(seed_perm)
      # attempt to add the link to role_permissions
      RoleAPI.create_link(db_role, db_perm)
    end)
  end

  @doc """
  Helper functions to insert list of data.

  insert_list(
    [%{name: "can_view_offer"}, ... ],
    Permission
  )
  """
  defp insert_list(data, schema) do
    Repo.insert_all(schema, data)
  end

  @doc """
  Gets difference between two lists.
  First argument should be larger otherwise will always return empty list.
  """
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
  def list_seed_permissions do
    AccountsData.permissions
    |> Map.values()
  end

  @doc """
  get seed data
  """
  def list_seed_roles do
    AccountsData.roles
    |> Map.keys()
    |> Enum.map(&Atom.to_string/1)
  end

  @doc """
  get seed data
  """
  def list_seed_roles_with_permissions do
    Seed.AccountsData.roles()
  end
end
