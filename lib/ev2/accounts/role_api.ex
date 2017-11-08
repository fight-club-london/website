defmodule Ev2.Accounts.RoleAPI do

  @moduledoc """
  Provides an API for dealing with the `Ev2.Accounts.Role` resource
  """

    import Ecto.Query, warn: false

    alias Ev2.Repo
    alias Ev2.Accounts.Role


    @doc """

  def get_by_name(name) do
    Repo.get_by(Role, name: name)
  end


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
    def list_roles do
      Repo.all(Role)
    end

    @doc """

    returns a list of only role names:

    [
      "super_admin",
      ...
    ]
    """
    def list_role_names do
      list_roles()
      |> Enum.map(fn role -> role.name end)
    end


end
