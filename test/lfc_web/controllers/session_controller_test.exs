defmodule LfcWeb.SessionControllerTest do
  @moduledoc """
  SessionController tests
  """
  use LfcWeb.ConnCase

  alias Lfc.{Accounts, Accounts.Cache}

  describe "new" do
    test "renders the login page when user not logged in", %{conn: conn} do
      conn = get(conn, session_path(conn, :new))
      assert html_response(conn, 200) =~ "New to engine?"
    end

    test "renders the dashboard when user logged in", %{conn: conn} do
      user = fixture(:user)
      conn =
        conn
        |> assign(:current_user, user)
      conn = get(conn, session_path(conn, :new))
      assert redirected_to(conn, 302) == dashboard_path(conn, :index)
    end
  end

  describe "create" do
    setup do
      user = fixture(:user)

      conn = assign(build_conn(), :current_user, Accounts.get_user(user.id))
      {:ok, conn: conn}
    end

    test "Get /sessions/new logged in", %{conn: conn} do
      conn = get conn, session_path(conn, :new)
      assert redirected_to(conn, 302) == dashboard_path(conn, :index)
    end

    test "Login: Valid session /session/new", %{conn: conn} do
      conn = post conn, session_path(conn, :create,
      %{"session" => %{"email" => "test@email.com", "password" => "Pass123!"}})
      assert redirected_to(conn, 302) == dashboard_path(conn, :index)
    end

    test "Login: Invalid session /sessions/new", %{conn: conn} do
      conn = post conn, session_path(conn, :create,
      %{"session" => %{"email" => "invalid@test.com", "password" => "invalid"}})
      assert html_response(conn, 302) =~ "/sessions/new"
    end

    test "Login: Invalid password", %{conn: conn} do
      conn = post conn, session_path(conn, :create,
      %{"session" => %{"email" => "test@email.com", "password" => "invld"}})
      assert html_response(conn, 302) =~ "/sessions/new"
    end

    test "Login: Not verified", %{conn: conn} do
      user = fixture(:user, %{verified: false, email: "test2@email.com"})
      conn = post conn, session_path(conn, :create,
      %{"session" => %{"email" => "test2@email.com", "password" => "Pass123!"}})
      {:ok, hash} = Cache.get(user.email)
      assert html_response(conn, 302) =~ "/verification/verify/#{hash}"
    end
  end

  describe "delete" do
    test "Logout", %{conn: conn} do
      user = fixture(:user)
      conn =
        conn
        |> assign(:current_user, user)
      conn = delete conn, session_path(conn, :delete, conn.assigns.current_user)
      assert redirected_to(conn, 302) == "/sessions/new"
    end
  end
end
