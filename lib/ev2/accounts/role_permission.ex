defmodule Ev2.Accounts.RolePermission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ev2.Accounts.{Role, Permission, RolePermission}


  schema "role_permissions" do
    belongs_to :role, Role
    belongs_to :permission, Permission

  end

  @doc false
  def changeset(%RolePermission{} = role_permission, attrs) do
    role_permission
    |> cast(attrs, [:role_id, :permission_id])
    |> validate_required([:role_id, :permission_id])
    |> unique_constraint(:unique_role_permissions, name: :unique_role_permissions)
  end
end
