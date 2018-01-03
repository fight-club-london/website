defmodule Lfc.Repo.Migrations.AddContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :name, :string
      add :email, :string
      add :mobile_number, :string
      add :message, :text

      timestamps()
    end
  end
end
