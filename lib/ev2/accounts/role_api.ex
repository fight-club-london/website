defmodule Ev2.Accounts.RoleAPI do

  @moduledoc """
  Provides an API for dealing with the `Ev2.Accounts.Role` resource
  """

  import Ecto.Query, warn: false

  alias Ev2.Repo
  alias Ev2.Accounts.{Role, Permission, RolePermission}


  @doc """
  get a role by id
  """
  def get_role!(id) do
    Repo.get!(Role, id)
  end

  def get_by_name(name) do
    Repo.get_by(Role, name: name)
  end

  def create_link(role = %Role{}, perm = %Permission{}) do
    link = %{role_id: role.id, permission_id: perm.id}
    changeset = RolePermission.changeset(%RolePermission{}, link)
    Repo.insert(changeset)
  end


  @doc """

  returns a list of role structs:

  [
    %Ev2.Accounts.Role{
      __meta__: #Ecto.Schema.Metadata<:loaded, "roles">,
      id: 1,
      name: "super_admin",
      roles: #Ecto.Association.NotLoaded<association :permissions is not loaded>
    },
    ...
  ]
  """
  def list do
    Repo.all(Role)
  end

  @doc """

  returns a list of only role names:

  [
    "super_admin",
    ...
  ]
  """
  def list_names do
    list()
    |> Enum.map(fn role -> role.name end)
  end


  @doc """
  returns a list of roles and their permissions preloaded
  """
  def list_with_permissions() do
    list()
    |> Repo.preload(:permissions)
  end


  @doc """
  returns a list of permission names for a list of roles
  """
  # def list_associated_permissions(roles) do
  #   list_roles()
  #   |> Enum.filter(
  #     fn %Role{name: name} -> Enum.member?(roles, name) end
  #   )
  #   |> Repo.preload(:permissions)
  # end
end
