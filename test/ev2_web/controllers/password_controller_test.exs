defmodule Ev2.PasswordControllerTest do
  @moduledoc """
  PasswordController tests
  """
  use Ev2Web.ConnCase

  import Mock

  alias Ev2.{Accounts, Accounts.Cache, Mailer}
  alias Phoenix.{Controller}

  setup do
    Cache.flushdb()
  end

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

  @valid_password %{
    password: "Password123!",
    password_confirmation: "Password123!"
  }

  @invalid_attrs %{
    active: "",
    email: "",
    first_name: "",
    last_name: "",
    password: "hehehe",
    password_hash: "",
    terms_accepted: "",
    verified: false
  }

  def fixture(:user, attrs \\ %{}) do
    combined_attrs = Map.merge(@create_attrs, attrs)
    {:ok, user} = Accounts.create_user(combined_attrs)
    user
  end

  describe "new" do
    test "renders the new password page", %{conn: conn} do
      conn = get(conn, password_path(conn, :new))
      assert html_response(conn, 200) =~ "Send reset email"
    end
  end

  describe "create" do
    test "password :create with recognised email address", %{conn: conn} do
    with_mock Mailer, [deliver_later: fn(_) -> nil end] do
        user = fixture(:user)
        conn = post(conn, password_path(conn, :create), user: @create_attrs)
        # test response
        assert redirected_to(conn) == password_path(conn, :new)
        assert Controller.get_flash(conn, :info) =~ "A password reset email has been sent to #{user.email}"
        # test Redis has key, which represents our email
        {:ok, [key]} = Cache.query(["keys", "*"])
        assert Cache.get(key) == {:ok, "test@email.com"}
        # test key is set to expire in 5 mins
        {:ok, ttl} = Cache.query(["ttl", key])
        assert ttl == 300
      end
    end

    test "password :create with fake email address", %{conn: conn} do
      conn = post(conn, password_path(conn, :create), user: @invalid_attrs)
      assert redirected_to(conn) == password_path(conn, :new)
      assert Controller.get_flash(conn, :error) =~ "No user found with that email"
    end
  end

  describe "edit" do
    test "password :edit with good email", %{conn: conn} do
      Cache.set("RAND0M5TR1NG", "test@email.com")
      conn = get conn, password_path(conn, :edit, 1, hash: "RAND0M5TR1NG")
      assert html_response(conn, 200) =~ "Reset password"
    end

    test "password :edit with bad email or expired link", %{conn: conn} do
      conn = get conn, password_path(conn, :edit, 1, hash: "RAND0M5TR1NG")
      assert Controller.get_flash(conn, :error) =~ "That link has expired"
      assert redirected_to(conn) =~ password_path(conn, :new)
    end
  end

  describe "update" do
    test "password :update with good email", %{conn: conn} do
      fixture(:user)
      Cache.set("RAND0M5TR1NG", "test@email.com")
      conn = put(
        conn,
        password_path(conn, :update, 1, hash: "RAND0M5TR1NG"),
        %{user: @valid_password}
      )
      assert Controller.get_flash(conn, :info) =~ "Password updated successfully"
      assert redirected_to(conn) =~ dashboard_path(conn, :index)

      # Log in user with new password
      valid_login = %{email: "test@email.com", password: "Password123!"}
      conn = post conn, session_path(conn, :create), %{session: valid_login}
      assert redirected_to(conn) =~ dashboard_path(conn, :index)
    end

    test "password :update with good email, but bad password/confirm password", %{conn: conn} do
      fixture(:user)
      Cache.set("RAND0M5TR1NG", "test@email.com")
      invalid_passwords = %{@valid_password | password_confirmation: "11111111"}
      conn = put(
        conn,
        password_path(conn, :update, 1, hash: "RAND0M5TR1NG"),
        %{user: invalid_passwords}
      )
      assert html_response(conn, 200) =~ "Passwords do not match"
    end

    test "password :update with expired/unrecognised email", %{conn: conn} do
      conn = put(
        conn,
        password_path(conn, :update, 1, hash: "RAND0M5TR1NG"),
        %{user: @valid_password}
      )
      assert Controller.get_flash(conn, :error) =~ "That link has expired"
      assert redirected_to(conn) =~ password_path(conn, :new)
    end
  end
end
