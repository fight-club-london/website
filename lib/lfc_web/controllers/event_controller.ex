defmodule LfcWeb.Main.EventController do
  use LfcWeb, :controller

  alias Lfc.Main

  def create(conn, %{"event" => event_params}) do
    case Main.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "New event added")
        |> redirect(to: admin_dashboard_path(conn, :index))
      {:error, changeset} ->
        fighters = Main.list_fighters()
        render(conn,
        Lfc.AdminDashboardView,
        "index.html",
        fighters: fighters,
        changeset: changeset)
    end
  end

end
