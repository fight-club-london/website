defmodule Lfc.Main.FighterApi do
  @moduledoc """
  Provides an API for all functions relating to fighters
  """
  defmacro __using__(_) do
    quote do

      alias Lfc.{Repo}
      alias Lfc.Main.{Fighter}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of fighters.

      ## Examples

          iex> list_fighters()
          [%Fighter{}, ...]

      """
      def list_fighters do
        query = from f in Fighter,
          order_by: f.inserted_at
        Repo.all(query)
      end

      @doc """
      Gets a single fighter.

      Raises `Ecto.NoResultsError` if the Fighter does not exist.

      ## Examples

          iex> get_fighter!(123)
          %Fighter{}

          iex> get_fighter!(456)
          ** (Ecto.NoResultsError)

      """

      def get_fighter!(id), do: Repo.get!(Fighter, id)

      @doc """
      Gets a single fighter.

      Returns nil if not exists

      ## Examples

          iex> get_fighter(123)
          %Fighter{}

          iex> get_fighter(456)
          nil

      """

      def get_fighter(id), do: Repo.get(Fighter, id)

      @doc """
      Gets a single fighter by email.

      ## Examples

          iex> get_fighter_by_email(example@email.com)
          %Fighter{}

          iex> get_fighter_by_email("")
          nil

      """
      def get_fighter_by_email(email), do: Repo.get_by(Fighter, email: email)

      @doc """
      Creates a fighter.

      ## Examples

          iex> create_fighter(%{field: value})
          {:ok, %Fighter{}}

          iex> create_fighter(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_fighter(attrs \\ %{}) do
        %Fighter{}
        |> Fighter.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking fighter changes.

      ## Examples

          iex> change_fighter(fighter)
          %Ecto.Changeset{source: %Fighter{}}

      """
      def change_fighter(%Fighter{} = fighter) do
        Fighter.changeset(fighter, %{})
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking fighter email changes.

      ## Examples

          iex> change_fighter_email(fighter)
          %Ecto.Changeset{source: %Fighter{}}

      """
      def change_fighter_email(%Fighter{} = fighter) do
        Fighter.email_changeset(fighter, %{})
      end

    end
  end
end
