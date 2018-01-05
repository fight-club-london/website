defmodule Lfc.Main.ContactApi do
  @moduledoc """
  Provides an API for all functions relating to contacts
  """
  defmacro __using__(_) do
    quote do

      alias Lfc.{Repo}
      alias Lfc.Main.{Contact}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of contacts.

      ## Examples

          iex> list_contacts()
          [%Contact{}, ...]

      """
      def list_contacts do
        query = from c in Contact,
          order_by: c.inserted_at
        Repo.all(query)
      end

      @doc """
      Gets a single contact.

      Raises `Ecto.NoResultsError` if the Contact does not exist.

      ## Examples

          iex> get_contact!(123)
          %Contact{}

          iex> get_contact!(456)
          ** (Ecto.NoResultsError)

      """

      def get_contact!(id), do: Repo.get!(Contact, id)

      @doc """
      Gets a single contact.

      Returns nil if not exists

      ## Examples

          iex> get_contact(123)
          %Contact{}

          iex> get_contact(456)
          nil

      """

      def get_contact(id), do: Repo.get(Contact, id)

      @doc """
      Gets a single contact by email.

      ## Examples

          iex> get_contact_by_email(example@email.com)
          %Contact{}

          iex> get_contact_by_email("")
          nil

      """
      def get_contact_by_email(email), do: Repo.get_by(Contact, email: email)

      @doc """
      Creates a contact.

      ## Examples

          iex> create_contact(%{field: value})
          {:ok, %Contact{}}

          iex> create_contact(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_contact(attrs \\ %{}) do
        %Contact{}
        |> Contact.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking contact changes.

      ## Examples

          iex> change_contact(contact)
          %Ecto.Changeset{source: %Contact{}}

      """
      def change_contact(%Contact{} = contact) do
        Contact.changeset(contact, %{})
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking contact email changes.

      ## Examples

          iex> change_contact_email(contact)
          %Ecto.Changeset{source: %Contact{}}

      """
      def change_contact_email(%Contact{} = contact) do
        Contact.email_changeset(contact, %{})
      end

    end
  end
end
