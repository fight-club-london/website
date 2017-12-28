defmodule Lfc.Main.EventApi do
  @moduledoc """
  Provides an API for all functions relating to events
  """
  defmacro __using__(_) do
    quote do

      alias Lfc.{Repo}
      alias Lfc.Main.{Event}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of events.

      ## Examples

          iex> list_events()
          [%Event{}, ...]

      """
      def list_events do
        query = from e in Event,
          order_by: e.date
        Repo.all(query)
      end

      @doc """
      Gets a single event.

      Raises `Ecto.NoResultsError` if the Event does not exist.

      ## Examples

          iex> get_event!(123)
          %Event{}

          iex> get_event!(456)
          ** (Ecto.NoResultsError)

      """

      def get_event!(id), do: Repo.get!(Event, id)

      @doc """
      Gets a single event.

      Returns nil if not exists

      ## Examples

          iex> get_event(123)
          %Event{}

          iex> get_event(456)
          nil

      """

      def get_event(id), do: Repo.get(Event, id)

      @doc """
      Creates a event.

      ## Examples

          iex> create_event(%{field: value})
          {:ok, %Event{}}

          iex> create_event(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_event(attrs \\ %{}) do
        %Event{}
        |> Event.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking event changes.

      ## Examples

          iex> change_event(event)
          %Ecto.Changeset{source: %Event{}}

      """
      def change_event(%Event{} = event) do
        Event.changeset(event, %{})
      end

    end
  end
end
