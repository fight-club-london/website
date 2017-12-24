defmodule Lfc.Accounts.Permission do
  @moduledoc """
  Permission Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Lfc.Accounts.{Permission, Role}

  schema "permissions" do
    field :name, :string
    many_to_many :roles, Role, join_through: "role_permissions"

  end

  @doc false
  def changeset(%Permission{} = permission, attrs) do
    permission
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
