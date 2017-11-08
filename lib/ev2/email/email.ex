defmodule Ev2.Email do
  @moduledoc """
  The Email context.
  """
  use Bamboo.Phoenix, view: Ev2Web.EmailView

  alias Ev2Web.{LayoutView}
  alias Ev2.{Utils, Mailer, Accounts}

  def send_text_email(recipient, subject, url, template, assigns \\ []) do
    new_email()
    |> to(recipient) # also needs to be a validated email
    |> from(System.get_env("ADMIN_EMAIL"))
    |> subject(subject)
    |> put_text_layout({LayoutView, "email.text"})
    |> render("#{template}.text", [url: url] ++ assigns)
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
    subject = "e n g i n e - verify your email"
    assigns = [
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    ]
    email = send_html_email(user.email, subject, url, "verify", assigns)

    email
    |> Mailer.deliver_later()
  end

end
