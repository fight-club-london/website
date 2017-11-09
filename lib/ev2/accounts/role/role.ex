defmodule Ev2.Accounts.Role do
  @moduledoc """
  Role schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Ev2.Accounts.{Role, Permission}

  schema "roles" do
    field :name, :string
    many_to_many :permissions, Permission, join_through: "role_permissions"
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
