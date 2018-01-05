defmodule Lfc.Email do
  @moduledoc """
  The Email context.
  """
  use Bamboo.Phoenix, view: LfcWeb.EmailView

  alias LfcWeb.{LayoutView}
  alias Lfc.{Utils, Mailer, Accounts, Accounts.Cache}

  def send_text_email(recipient, subject, url, template, assigns \\ []) do
    new_email()
    |> to(recipient) # also needs to be a validated email
    |> from(System.get_env("ADMIN_EMAIL"))
    |> subject(subject)
    |> put_text_layout({LayoutView, "email.text"})
    |> render("#{template}.text", assigns)
  end

  def send_html_email(recipient, subject, url, template, assigns \\ []) do
    recipient
    |> send_text_email(subject, url, template, assigns)
    |> put_html_layout({LayoutView, "email.html"})
    |> render("#{template}.html", [url: url] ++ assigns)
  end

  def send_verification_email(user) do
    rand_string = Accounts.set_as_value(user.email)
    url = "#{Utils.get_base_url()}/verification/#{rand_string}"
    subject = "verify your email"
    assigns = [
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    ]
    email = send_html_email(user.email, subject, url, "verify", assigns)

    email
    |> Mailer.deliver_later()
  end

  def send_reset_password_email(user, url) do
    rand_string = Utils.gen_rand_string(30)
    Cache.query(["SET", rand_string, user.email])
    Cache.expire(rand_string, 60 * 5)
    url = url <> "?hash=#{rand_string}"
    assigns = [
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    ]
    email = send_html_email(
      user.email,
      "reset your password",
      url,
      "password_reset",
      assigns
    )

    email
    |> Mailer.deliver_later()
  end

  def send_new_fighter_email(fighter) do
    email =
      new_email()
      |> to(System.get_env("ADMIN_EMAIL"))
      |> from(System.get_env("ADMIN_EMAIL"))
      |> subject("New fighter signed up!")
      |> put_text_layout({LayoutView, "email.text"})
      |> render("new_fighter.text", [fighter: fighter])

    email
    |> Mailer.deliver_later()
  end

end
