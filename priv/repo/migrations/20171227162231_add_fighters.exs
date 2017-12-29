defmodule Lfc.Repo.Migrations.AddFighters do
  use Ecto.Migration

  def change do
    create table(:fighters) do
      add :title, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :mobile_number, :string
      add :occupation, :string
      add :location, :string

      timestamps()
    end
  end
end
