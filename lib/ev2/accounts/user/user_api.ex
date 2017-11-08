defmodule Ev2.Accounts.UserAPI do
  @moduledoc """
  Provides an API for all functions relating to users
  """
  defmacro __using__(_) do
    quote do

      alias Ev2.{Repo}
      alias Ev2.Accounts.{User, Role}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of users.

      ## Examples

          iex> list_users()
          [%User{}, ...]

      """
      def list_users do
        Repo.all(User)
      end

      @doc """
      Gets a single user.

      Raises `Ecto.NoResultsError` if the User does not exist.

      ## Examples

          iex> get_user!(123)
          %User{}

          iex> get_user!(456)
          ** (Ecto.NoResultsError)

      """
      def get_user!(id), do: Repo.get!(User, id)

      @doc """
      Creates a user.

      ## Examples

          iex> create_user(%{field: value})
          {:ok, %User{}}

          iex> create_user(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_user(attrs \\ %{}) do
        # %{"user_type" => user_type} = attrs
        # role = Repo.get_by(Role, name: user_type)
        %User{}
        |> User.registration_changeset(attrs)
        # |> Changeset.put_assoc(:role, role)
        |> Repo.insert()
      end

      @doc """
      Updates a user.

      ## Examples

          iex> update_user(user, %{field: new_value})
          {:ok, %User{}}

          iex> update_user(user, %{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def update_user(%User{} = user, attrs) do
        user
        |> User.changeset(attrs)
        |> Repo.update()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking user changes.

      ## Examples

          iex> change_user(user)
          %Ecto.Changeset{source: %User{}}

      """
      def change_user(%User{} = user) do
        User.changeset(user, %{})
      end

    end
  end
end
