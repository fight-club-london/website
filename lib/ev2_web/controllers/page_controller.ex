defmodule Ev2Web.PageController do
  use Ev2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
