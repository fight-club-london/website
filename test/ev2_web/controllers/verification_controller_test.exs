defmodule Ev2.VerificationControllerTest do
  @moduledoc """
  VerificationController tests
  """
  use Ev2Web.ConnCase

  alias Ev2.{Cache}

  import Mock

  alias Ev2.{Accounts, Mailer}
  alias Ev2.Accounts.{Cache}

  setup do
    Cache.flushdb()
  end

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

  describe "verify" do
    test "/verification/:hash email exists", %{conn: conn} do
      user = fixture(:user)
      Cache.set("RAND0M5TR1NG", user.email)
      conn = get conn, "/verification/RAND0M5TR1NG"
      assert redirected_to(conn, 302) == "/"
    end

    test "/verification/:hash email exists verified user", %{conn: conn} do
      user = fixture(:user)
      Cache.set("RAND0M5TR1NG", user.email)
      conn = get conn, "/verification/RAND0M5TR1NG"
      assert redirected_to(conn, 302) == "/"
    end

    test "/verification/:hash email exists in Redis, not Postgres", %{conn: conn} do
      Cache.set("RAND0M5TR1NG", "test@email.com")
      conn = get conn, "/verification/RAND0M5TR1NG"
      assert redirected_to(conn, 302) == "/users/new"
    end

    test "/verification/:hash email doesn't exist", %{conn: conn} do
      conn = get conn, "/verification/RAND0M5TR1NG"
      assert redirected_to(conn, 302) == "/users/new"
    end

    test "/verification/:hash user already verified", %{conn: conn} do
      user = fixture(:user, %{verified: true})
      Cache.set("RAND0M5TR1NG", user.email)
      conn = get conn, "/verification/RAND0M5TR1NG"
      assert redirected_to(conn, 302) == "/"
    end
  end

  describe "verify_again" do
    test "/verification/verify/:hash", %{conn: conn} do
      conn = get conn, verification_path(conn, :verify_again, "RAND0M5TR1NG")
      assert html_response(conn, 200) =~ "Verification email"
    end
  end

  describe "resend" do
    test "/verification/resend/:hash", %{conn: conn} do
      with_mock Mailer, [deliver_later: fn(_) -> nil end] do
        user = fixture(:user)
        Cache.set("RAND0M5TR1NG", user.email)
        conn = get conn, verification_path(conn, :resend, "RAND0M5TR1NG")
        assert redirected_to(conn, 302) == "/sessions/new"
      end
    end
  end

end
