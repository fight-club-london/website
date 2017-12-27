defmodule LfcWeb.AdminDashboardController do
  use LfcWeb, :controller

  alias LfcWeb.LayoutView

  def index(conn, _params) do
    render conn, "index.html", layout: {LayoutView, "admin.html"}
  end
end
