defmodule Ev2Web.AuthTest do
  @moduledoc """
  Authentication tests
  """
  use Ev2Web.ConnCase, async: false

  alias Ev2.{Accounts, Accounts.User}
  alias Ev2Web.{Auth, Router}

  describe "auth" do
    setup %{conn: conn} do
      conn =
        conn
        |> bypass_through(Router, :browser)
        |> get("/")

      {:ok, %{conn: conn}}
    end

    test "testing init function", do: assert Auth.init([accounts: 1])

    test "authenticate_user halts when no current_user exists", %{conn: conn} do
      conn = Auth.authenticate(conn, [])

      assert conn.halted
    end

    test "authenticate continues when the current_user exists", %{conn: conn} do
      conn =
        conn
        |> assign(:current_user, %User{})
        |> Auth.authenticate([])
      refute conn.halted
    end

    test "login puts the user in the session", %{conn: conn} do
      login_conn =
        conn
        |> Auth.login(%User{id: 1})
        |> send_resp(:ok, "")
      next_conn = get(login_conn, "/")
      assert get_session(next_conn, :user_id) == 1
    end

    test "logout drops the session", %{conn: conn} do
      logout_conn =
        conn
        |> put_session(:user_id, 1)
        |> Auth.logout()
        |> send_resp(:ok, "")

      next_conn = get(logout_conn, "/")
      refute get_session(next_conn, :user_id)
    end

    test "call places user from session into assigns", %{conn: conn} do
      user = fixture(:user)
      conn =
        conn
        |> put_session(:user_id, user.id)
        |> Auth.call(Accounts)

      assert conn.assigns.current_user.id == user.id
    end

    test "call returns conn when current_user is assigned", %{conn: conn} do
      user = fixture(:user)
      conn =
        conn
        |> assign(:current_user, Accounts.get_user_by_email("test@email.com"))
        |> put_session(:user_id, user.id)
        |> Auth.call(Accounts)

      assert conn.assigns.current_user.id == user.id
    end

    test "call with no session sets current_user assign to nil", %{conn: conn} do
      conn = Auth.call(conn, Accounts)
      assert conn.assigns.current_user == nil
    end

    test "login with a valid username and pass", %{conn: conn} do
      user = fixture(:user)
      {:ok, conn} =
        Auth.login_by_email_and_pass(conn, "test@email.com", "Pass123!", accounts: Accounts)

      assert conn.assigns.current_user.id == user.id
    end

    test "login with a not found user", %{conn: conn} do
      assert {:error, :unauthorized, _conn} =
        Auth.login_by_email_and_pass(conn, "notemail@nottest.com", "supersecret", accounts: Accounts)
    end

    test "login with password mismatch", %{conn: conn} do
      fixture(:user)
      assert {:error, :unauthorized, _conn} =
        Auth.login_by_email_and_pass(conn, "test@email.com", "wrong", accounts: Accounts)
    end

    test "login with not verified user", %{conn: conn} do
      fixture(:user, %{verified: false})
      assert {:error, :not_verified, _conn} =
        Auth.login_by_email_and_pass(conn, "test@email.com", "Pass123!", accounts: Accounts)
    end
  end
end
