defmodule Ev2.TestHelpers do
  @moduledoc """
  Test helpers
  """

  alias Ev2.{Accounts}
  alias Phoenix.{ConnTest}
  alias Plug.{Conn}

  def mother_setup do
    user = fixture(:user)
    conn = login_user(ConnTest.build_conn, user)

    {
      :ok,
      conn: conn,
      user: user
    }
  end

  @create_user_attrs %{
    active: true,
    email: "test@email.com",
    first_name: "first_name",
    last_name: "last_name",
    password: "Pass123!",
    password_hash: "some password_hash",
    terms_accepted: true,
    verified: true
  }

  def fixture(:user, attrs \\ %{}) do
    merged_attrs = Map.merge(@create_user_attrs, attrs)
    {:ok, user} = Accounts.create_user(merged_attrs)
    user
  end

  def login_user(conn, user) do
    conn
    |> Conn.assign(:current_user, user)
  end
end
