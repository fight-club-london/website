defmodule LfcWeb.DashboardController do
  @moduledoc """
  Dashboard Controller
  """
  use LfcWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
