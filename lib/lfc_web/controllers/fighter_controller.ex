defmodule LfcWeb.FighterController do
  @moduledoc """
  Fighter Controller
  """
  use LfcWeb, :controller

  alias Lfc.Main.Fighter
  alias Lfc.Main
  alias LfcWeb.LayoutView
  alias Lfc.Email
  alias ExTwilio.Message

  def new(conn, _params) do
    changeset = Fighter.changeset(%Fighter{})

    render(
      conn,
      "new.html",
      layout: {LayoutView, "sign_up.html"},
      changeset: changeset)
  end

  def create(conn, %{"fighter" => fighter_params}) do
    case Main.create_fighter(fighter_params) do
      {:ok, fighter} ->
        # text the fighter
        number =
          case String.contains?(fighter.mobile_number, "+44") do
            true -> fighter.mobile_number
            false -> String.replace_leading(fighter.mobile_number, "0", "+44")
          end
        Message.create(to: number,
          from: "Fight Club",
          body: "Thanks for signing up #{fighter.first_name}! \n Welcome to Fight Club")
        # email admin
        Email.send_new_fighter_email(fighter)
        render conn, "thank_you.html", fighter: fighter
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops something went wrong! Check the errors below")
        |> render("new.html", changeset: changeset)
    end
  end

  def thank_you(conn, _params) do
    render conn, "thank_you.html", fighter: nil
  end

end
