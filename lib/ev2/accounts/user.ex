defmodule Ev2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ev2.Accounts.{User, Role}


  schema "users" do
    field :active, :boolean, nil: false, default: true
    field :email, :string, nil: false
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string, nil: false
    field :terms_accepted, :boolean, nil: false, default: false
    field :verified, :boolean, nil: false, default: false
    belongs_to :role, Role
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :password,
      :password_hash,
      :verified,
      :terms_accepted,
      :active
    ])
    |> validate_required([
      :email,
      :first_name,
      :last_name,
      :password,
      :password_hash,
      :verified,
      :terms_accepted,
      :active
    ])
    |> unique_constraint(:email)
  end
end
