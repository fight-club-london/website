defmodule LfcWeb.DashboardController do
  @moduledoc """
  Dashboard Controller
  """
  use LfcWeb, :controller
  alias Lfc.Main
  alias Lfc.Main.Contact

  def index(conn, _params) do
    message = ExTwilio.Message.create(to: "+447590375510",
      from: "Fight Club",
      body: "Thanks for signing up!")
    IO.inspect message
    events = Main.list_events()
    changeset = Contact.changeset(%Contact{})
    render conn, "index.html", events: events, changeset: changeset
  end

end
