defmodule Ev2.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :role_id, references(:roles, on_delete: :nothing)
      add :permission_id, references(:permissions, on_delete: :nothing)
    end
    
    create index(:role_permissions, [:role_id])
    create index(:role_permissions, [:permission_id])
    create unique_index(:role_permissions, [:role_id, :permission_id], name: :unique_role_permissions)
  end
end
