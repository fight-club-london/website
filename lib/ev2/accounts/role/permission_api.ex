defmodule Ev2.Accounts.PermissionAPI do

  @moduledoc """
  Provides an API for dealing with the `Ev2.Accounts.Permission` resource
  """

    import Ecto.Query, warn: false

    alias Ev2.Repo
    alias Ev2.Accounts.Permission

    def get_by_name(name) do
      Repo.get_by(Permission, name: name)
    end

    @doc """

    returns a list of permisssion structs:

    [
      %Ev2.Accounts.Permission{
        __meta__: #Ecto.Schema.Metadata<:loaded, "permissions">,
        id: 1,
        name: "can_create_offer",
        roles: #Ecto.Association.NotLoaded<association :roles is not loaded>
      },
      ...
    ]
    """
    def list_permissions do
      Repo.all(Permission)
    end

    @doc """

    returns a list of only permission names:

    [
      "can_view_offer",
      ...
    ]
    """
    def list_permission_names do
      list_permissions()
      |> Enum.map(fn permission -> permission.name end)
    end

end
