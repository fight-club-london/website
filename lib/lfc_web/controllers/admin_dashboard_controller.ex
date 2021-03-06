defmodule LfcWeb.AdminDashboardController do
  use LfcWeb, :controller

  alias LfcWeb.LayoutView
  alias Lfc.Main
  alias Lfc.Main.{Event}

  def index(conn, _params) do
    events = Main.list_events()
    fighters = Main.list_fighters()
    contacts = Main.list_contacts()
    changeset = Main.change_event(%Event{})
    render(conn,
    "index.html",
    layout: {LayoutView, "admin.html"},
    fighters: fighters,
    contacts: contacts,
    events: events,
    changeset: changeset)
  end
end
