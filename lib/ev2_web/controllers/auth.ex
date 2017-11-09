defmodule Ev2.Auth do

  @moduledoc """
  Handles authentication
  """
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller

  alias Ev2Web.{Router.Helpers}

  def init(opts) do
    Keyword.fetch!(opts, :accounts)
  end

  def call(conn, accounts) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:current_user] ->
        conn
      user = user_id && accounts.get_user(user_id) ->
        assign(conn, :current_user, user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_pass(conn, email, given_pass, opts) do
    accounts = Keyword.fetch!(opts, :accounts)
    user = accounts.get_user_by_email(email)

    cond do
      user && checkpw(given_pass, user.password_hash) && user.verified ->
        {:ok, login(conn, user)}
      user && checkpw(given_pass, user.password_hash) && !user.verified ->
        {:error, :not_verified, conn}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :unauthorized, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
        conn
    else
      conn
      |> put_flash(:error, "You must be logged in to view that page")
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end

end
