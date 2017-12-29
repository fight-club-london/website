defmodule LfcWeb.EventController do
  use LfcWeb, :controller
  alias Lfc.Main

  def create(conn, %{"event" => event_params}) do
    case Main.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "New event created!")
        |> redirect(to: admin_dashboard_path(conn, :index))
      {:error, changeset} ->
        events = Main.list_events()
        fighters = Main.list_fighters()
        render(conn,
        LfcWeb.AdminDashboardView,
        "index.html",
        fighters: fighters,
        changeset: changeset,
        events: events)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Main.get_event!(id)
    {:ok, _document} = Main.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully!")
    |> redirect(to: admin_dashboard_path(conn, :index))
  end

end
