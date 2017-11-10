defmodule Ev2Web.DashboardControllerTest do
  @moduledoc """
  DashboardController tests
  """
  use Ev2Web.ConnCase

  alias Ev2.{Accounts}

  @create_attrs %{
    active: true,
    email: "test@email.com",
    first_name: "first_name",
    last_name: "last_name",
    password: "123Testpassword!",
    password_hash: "some password_hash",
    terms_accepted: true,
    verified: false
  }

  def fixture(:user, attrs \\ %{}) do
    combined_attrs = Map.merge(@create_attrs, attrs)
    {:ok, user} = Accounts.create_user(combined_attrs)
    user
  end

  describe "index" do
    test "renders the dashboard when logged in", %{conn: conn} do
      user = fixture(:user, %{verified: true})
      conn =
        conn
        |> assign(:current_user, user)
      conn = get(conn, dashboard_path(conn, :index))
      assert html_response(conn, 200) =~ "Dashboard"
    end

    test "redirects to login when not logged in", %{conn: conn} do
      conn = get(conn, dashboard_path(conn, :index))
      assert redirected_to(conn, 302) == session_path(conn, :new)
    end
  end
end
