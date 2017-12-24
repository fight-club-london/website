defmodule Lfc.Repo.Migrations.CreateUsers do
  @moduledoc """
  User migration
  """
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string, null: false
      add :verified, :boolean, default: false, null: false
      add :terms_accepted, :boolean, default: false, null: false
      add :active, :boolean, default: true, null: false
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role_id])
    create unique_index(:users, [:email])
  end
end
