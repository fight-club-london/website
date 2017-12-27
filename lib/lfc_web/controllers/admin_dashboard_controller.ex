defmodule LfcWeb.AdminDashboardController do
  use LfcWeb, :controller

  alias LfcWeb.LayoutView
  alias Lfc.Main

  def index(conn, _params) do
    fighters = Main.list_fighters()
    render(conn,
    "index.html",
    layout: {LayoutView, "admin.html"},
    fighters: fighters)
  end
end
