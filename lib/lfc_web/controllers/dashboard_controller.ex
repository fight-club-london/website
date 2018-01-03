defmodule LfcWeb.DashboardController do
  @moduledoc """
  Dashboard Controller
  """
  use LfcWeb, :controller
  alias Lfc.Main

  def index(conn, _params) do
    events = Main.list_events()
    render conn, "index.html", events: events
  end

end
