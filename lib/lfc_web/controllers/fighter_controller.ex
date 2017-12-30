defmodule LfcWeb.FighterController do
  @moduledoc """
  Fighter Controller
  """
  use LfcWeb, :controller

  alias LfcWeb.{LayoutView}
  alias Lfc.Main.Fighter

  def new(conn, _params) do
    changeset = Fighter.changeset(%Fighter{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Auth.login_by_email_and_pass(conn, email, pass, accounts: Accounts) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: admin_dashboard_path(conn, :index))
      {:error, :unauthorized, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> redirect(to: session_path(conn, :new))
      {:error, :not_verified, conn} ->
        rand_string = Accounts.set_as_key_and_value(email)
        conn
        |> put_flash(:error, "Your email address is yet to be verified")
        |> redirect(to: verification_path(conn, :verify_again, rand_string))
    end
  end

end
