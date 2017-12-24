defmodule LfcWeb.DashboardControllerTest do
  @moduledoc """
  DashboardController tests
  """
  use LfcWeb.ConnCase

  alias Lfc.{Accounts}

  describe "index" do
    test "renders the dashboard when logged in", %{conn: conn} do
      user = fixture(:user)
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
