defmodule LfcWeb.EventController do
  use LfcWeb, :controller
  alias Lfc.Main

  def create(conn, %{"event" => event_params}) do
    case Main.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "New event added!")
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

end
