defmodule Ev2.Repo.Migrations.CreateUsers do
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
      add :startpack_id, references(:startpacks, on_delete: :delete_all)
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role_id])
    create index(:users, [:startpack_id])
    create index(:users, [:company_id])
    create unique_index(:users, [:email])
  end
end
