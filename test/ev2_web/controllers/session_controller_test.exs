defmodule Ev2.SessionControllerTest do
  @moduledoc """
  SessionController tests
  """
  use Ev2Web.ConnCase

  alias Ev2.{Accounts, Accounts.Cache}

  @create_attrs %{
    active: true,
    email: "test@email.com",
    first_name: "first_name",
    last_name: "last_name",
    password: "Pass123!",
    password_hash: "some password_hash",
    terms_accepted: true,
    verified: false
  }

  def fixture(:user, attrs \\ %{}) do
    combined_attrs = Map.merge(@create_attrs, attrs)
    {:ok, user} = Accounts.create_user(combined_attrs)
    user
  end

  describe "new" do
    test "renders the login page when user not logged in", %{conn: conn} do
      conn = get(conn, session_path(conn, :new))
      assert html_response(conn, 200) =~ "New to engine?"
    end

    test "renders the dashboard when user logged in", %{conn: conn} do
      user = fixture(:user, %{verified: true})
      conn =
        conn
        |> assign(:current_user, user)
      conn = get(conn, session_path(conn, :new))
      assert redirected_to(conn, 302) == dashboard_path(conn, :index)
    end
  end

  describe "create" do
    setup do
      user = fixture(:user, %{verified: true})

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
      user = fixture(:user, %{email: "test2@test.com", verified: false})
      conn = post conn, session_path(conn, :create,
      %{"session" => %{"email" => "test2@test.com", "password" => "Pass123!"}})
      {:ok, hash} = Cache.get(user.email)
      assert html_response(conn, 302) =~ "/verification/verify/#{hash}"
    end
  end

  describe "delete" do
    test "Logout", %{conn: conn} do
      user = fixture(:user, %{email: "test2@test.com", verified: true})
      conn =
        conn
        |> assign(:current_user, user)
      conn = delete conn, session_path(conn, :delete, conn.assigns.current_user)
      assert redirected_to(conn, 302) == "/sessions/new"
    end
  end
end
