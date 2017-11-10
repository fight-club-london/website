defmodule Ev2Web.PasswordController do
  use Ev2Web, :controller

  alias Ev2Web.{Auth, LayoutView}
  alias Ev2.{Accounts, Accounts.User, Email, Utils}

  def new(conn, _params) do
    changeset = Accounts.change_user_email(%User{})
    render(
      conn,
      "new.html",
      layout: {LayoutView, "pre_login.html"},
      changeset: changeset
    )
  end

  def create(conn, %{"user" => password_params}) do
    # if they are there, send email, store in redis, expire
    email = password_params["email"]
    case user = Accounts.get_user_by_email(email) do
      nil ->
        # if user not found, just let them know something not working
        message = "No user found with that email, check you have entered the one
          you signed up with"

        conn
        |> put_flash(:error, message)
        |> redirect(to: password_path(conn, :new))
      %User{} ->
        # if email is found, send reset email
        # need to hash the user id!
        url = Utils.get_base_url() <> password_path(conn, :edit, user.id)
        Email.send_reset_password_email(user, url)
        message = "A password reset email has been sent to #{user.email}, it will
          expire in 5 minutes"

        conn
        |> put_flash(:info, message)
        |> redirect(to: password_path(conn, :new))
    end
  end

  def edit(conn, %{"hash" => hash}) do
    # render form for create new password and confirm new password
    case Accounts.get_email_from_hash(hash) do
      {:error, _} ->
        message = "That link has expired, please enter your email address
          to receive a new password reset email"
        conn
        |> put_flash(:error, message)
        |> redirect(to: password_path(conn, :new))
      {:ok, _email} ->
        changeset = Accounts.change_password(%User{})
        render(
          conn,
          "edit.html",
          layout: {LayoutView, "pre_login.html"},
          changeset: changeset,
          hash: hash
        )
    end
  end

  def update(conn, %{"user" => password_params, "hash" => hash}) do
    # if password valid, update user
    case Accounts.get_email_from_hash(hash) do
      {:error, _} ->
        message = "That link has expired, please enter your email address to
          receive a new password reset email"

        conn
        |> put_flash(:error, message)
        |> redirect(to: password_path(conn, :new))
      {:ok, email} ->
        user = Accounts.get_user_by_email(email)
        case Accounts.update_password(user, password_params) do
          {:ok, user} ->
            conn
            |> Auth.login(user)
            |> put_flash(:info, "Password updated successfully")
            |> redirect(to: dashboard_path(conn, :index))
          {:error, changeset} ->
            render(
              conn,
              "edit.html",
              layout: {LayoutView, "pre_login.html"},
              hash: hash,
              changeset: changeset
            )
        end
    end
  end
end
