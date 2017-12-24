defmodule Ev2Web.DashboardController do
  @moduledoc """
  Dashboard Controller
  """
  use Ev2Web, :controller

  def index(conn, _params, user) do
    case user == nil do
      true ->
        conn
        |> redirect(to: session_path(conn, :new))
        |> halt()
      false ->
        render conn, "index.html"
    end
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end
end
