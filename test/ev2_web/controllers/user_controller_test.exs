defmodule Ev2Web.UserControllerTest do
  use Ev2Web.ConnCase

  alias Ev2.Accounts
  alias Ev2.Accounts.{Cache}

  @create_attrs %{active: true, email: "test@email.com", first_name: "first_name", last_name: "last_name", password: "123Testpassword!", password_hash: "some password_hash", terms_accepted: true, verified: false}
  @invalid_attrs %{active: nil, email: nil, first_name: nil, last_name: nil, password: "hehehe", password_hash: nil, terms_accepted: nil, verified: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "Create account"
    end

    test "renders form with target email query param", %{conn: conn} do
      Cache.query(["SET", "random-string", "test@email.com"])
      conn = get conn, user_path(conn, :new, te: "random-string")
      assert html_response(conn, 200) =~ "Create account"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert redirected_to(conn, 302) == user_path(conn, :new)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Create account"
    end
  end

  # describe "edit user" do
  #   setup [:create_user]
  #
  #   test "renders form for editing chosen user", %{conn: conn, user: user} do
  #     conn = get conn, user_path(conn, :edit, user)
  #     assert html_response(conn, 200) =~ "Edit User"
  #   end
  # end

  # describe "update user" do
  #   setup [:create_user]
  #
  #   test "redirects when data is valid", %{conn: conn, user: user} do
  #     conn = put conn, user_path(conn, :update, user), user: @update_attrs
  #     assert redirected_to(conn) == user_path(conn, :show, user)
  #
  #     conn = get conn, user_path(conn, :show, user)
  #     assert html_response(conn, 200) =~ "some updated email"
  #   end
  #
  #   test "renders errors when data is invalid", %{conn: conn, user: user} do
  #     conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
  #     assert html_response(conn, 200) =~ "Edit User"
  #   end
  # end
end
