defmodule Lfc.Main.Contact do

  @moduledoc """
  Provides fighter schema and changeset functionality
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :name, :string
    field :email, :string
    field :mobile_number, :string
    field :message, :string
    timestamps()
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :name,
      :email,
      :mobile_number,
      :message
    ])
    |> validate_required([
      :name,
      :email,
      :mobile_number,
      :message
    ])
    |> email_changeset(attrs)
    |> number_changeset(attrs)
  end

  def email_changeset(changeset, attrs \\ %{}) do
    email_format = ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    changeset
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, email_format)
    |> unique_constraint(:email)
  end

  def number_changeset(changeset, attrs \\ %{}) do
    changeset
    |> cast(attrs, [:mobile_number])
    |> validate_required([:mobile_number])
    |> validate_format(:mobile_number, ~r/^[0-9]+$/)
    |> validate_length(:mobile_number, min: 8)
  end

end
