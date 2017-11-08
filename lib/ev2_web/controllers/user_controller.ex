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
    ops = get_target_email(conn.query_params)
    render(
      conn,
      "new.html",
      [layout: {LayoutView, "pre_login.html"},
      changeset: changeset] ++ ops
    )
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Ev2.Email.send_verification_email(user)
        # *** to be inserted when offers exist *** [
        # update all offers user_ids that have been sent to this user
        # ]
        message = "A verification email has been sent to #{user.email}.
        Click the link in the email to gain full access to engine"
        conn
        |> put_flash(:info, message)
        |> redirect(to: session_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        ops = get_target_email(conn.query_params)
        render(
          conn,
          "new.html",
          [layout: {LayoutView, "pre_login.html"},
          changeset: changeset] ++ ops
        )
    end
  end

  # def edit(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   changeset = Accounts.change_user(user)
  #   render(conn, "edit.html", user: user, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user!(id)
  #
  #   case Accounts.update_user(user, user_params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, "User updated successfully.")
  #       |> redirect(to: user_path(conn, :show, user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", user: user, changeset: changeset)
  #   end
  # end

  defp get_target_email(query_params) do
    case Map.has_key?(query_params, "te") do
      true ->
        target_email_hash = query_params["te"]
        target_email = Accounts.get_target_email(target_email_hash)
        [
          target_email: target_email,
          target_email_hash: target_email_hash
        ]
      false ->
        [
          target_email: nil,
          target_email_hash: nil
        ]
    end
  end
end
