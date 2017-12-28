defmodule LfcWeb.AdminDashboardController do
  use LfcWeb, :controller

  alias LfcWeb.LayoutView
  alias Lfc.Main
  alias Lfc.Main.{Event}

  def index(conn, _params) do
    fighters = Main.list_fighters()
    changeset = Main.change_event(%Event{})
    render(conn,
    "index.html",
    layout: {LayoutView, "admin.html"},
    fighters: fighters,
    changeset: changeset)
  end
end
