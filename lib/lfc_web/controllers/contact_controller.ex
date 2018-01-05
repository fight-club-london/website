defmodule LfcWeb.ContactController do
  @moduledoc """
  Contact Controller
  """
  use LfcWeb, :controller

  alias Lfc.Main.Contact
  alias Lfc.Main

  def create(conn, %{"contact" => contact_params}) do
    case Main.create_contact(contact_params) do
      {:ok, contact} ->
        # text the contact
        # email admin
        conn
        |> put_flash(:info, "Thanks #{contact.name}, we'll be in touch")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, changeset} ->
        events = Main.list_events()
        conn
        |> put_flash(:error, "Oops something went wrong! Check the errors below")
        |> render(
          LfcWeb.DashboardView,
          "index.html",
          changeset: changeset,
          events: events)
    end
  end

end
