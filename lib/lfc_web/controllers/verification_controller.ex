defmodule LfcWeb.VerificationController do
  use LfcWeb, :controller

  alias Lfc.{Accounts.User}
  alias Lfc.{Email, Accounts}
  alias LfcWeb.{Auth}

  def verify(conn, %{"hash" => hash}) do
    case Accounts.get_email_from_hash(hash) do
      {:error, _error} ->
        conn
        |> put_flash(:error, "User doesn't exist")
        |> redirect(to: user_path(conn, :new))
      {:ok, email} ->
        case Accounts.get_user_by_email(email) do
          nil ->
            conn
            |> put_flash(:error, "User doesn't exist")
            |> redirect(to: user_path(conn, :new))
          user = %User{verified: true} ->
            conn
            |> put_flash(:error, "Email #{user.email} already verified")
            |> redirect(to: dashboard_path(conn, :index))
          user = %User{verified: false} ->
            user = Accounts.verify_user(user)
            conn
            |> Auth.login(user)
            |> put_flash(:info, "Email #{user.email} verified")
            |> redirect(to: dashboard_path(conn, :index))
          end
      end
  end

  def verify_again(conn, %{"hash" => hash}) do
    render conn, "verify_again.html", hash: hash
  end

  def resend(conn, %{"hash" => hash}) do
    {:ok, email} = Accounts.get_email_from_hash(hash)
    user = Accounts.get_user_by_email(email)
    Email.send_verification_email(user)

    conn
    |> put_flash(:info, "A new verification email has been sent to #{user.email}")
    |> redirect(to: session_path(conn, :new))
  end

end
