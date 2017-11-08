defmodule Ev2Web.SessionController do
  @moduledoc """
  Session Controller
  """
  use Ev2Web, :controller

  alias Ev2.{Accounts.User, Auth}
  alias Ev2Web.{LayoutView}

  def new(conn, _params) do
    case conn.assigns.current_user do
      nil ->
        changeset = User.changeset(%User{})
        render(
          conn,
          "new.html",
          layout: {LayoutView, "pre_login.html"},
          changeset: changeset
        )
      _user ->
        conn
        |> put_flash(:info, "You are already logged in!")
        |> redirect(to: dashboard_path(conn, :index))
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: session_path(conn, :new))
  end
  
end
