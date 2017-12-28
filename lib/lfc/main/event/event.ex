defmodule Lfc.Main.Event do

  @moduledoc """
  Provides event schema and changeset functionality
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "fighters" do
    field :date, :date
    timestamps()
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end

end
