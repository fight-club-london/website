defmodule Ev2Web.DashboardController do
  @moduledoc """
  Dashboard Controller
  """
  use Ev2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
