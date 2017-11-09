defmodule Ev2Web.PasswordController do
  use Ev2Web, :controller

  alias Ev2Web.{LayoutView}
  alias Ev2.{Accounts, Accounts.User}

  def new(conn, _params) do
    changeset = Accounts.change_user_email(%User{})
    render conn, "new.html", layout: {LayoutView, "pre_login.html"}, changeset: changeset
  end
end
