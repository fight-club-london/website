defmodule Ev2Web.UserController do
  use Ev2Web, :controller

  alias Ev2.Accounts
  alias Ev2.Accounts.User
  alias Ev2Web.{LayoutView}

  # admin view only
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    case Map.has_key?(conn.query_params, "te") do
      true ->
        target_email_hash = conn.query_params["te"]
        target_email = Accounts.get_target_email(target_email_hash)
        render(conn, "new.html", layout: {LayoutView, "pre_login.html"}, changeset: changeset, target_email: target_email, target_email_hash: target_email_hash)
      false ->
        render(conn, "new.html", layout: {LayoutView, "pre_login.html"}, changeset: changeset, target_email: nil, target_email_hash: nil)
    end
  end

  def create(conn, %{"user" => %{"crew" => crew} = user_params}) do
    crew = crew == "true"
    user_type =
      case crew do
        true -> "CREW"
        false -> "COMPANY"
      end
    case Accounts.create_user(user_type, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.email} created successfully.")
        |> redirect(to: user_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", layout: {LayoutView, "pre_login.html"}, changeset: changeset, target_email: nil, target_email_hash: nil)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
