defmodule LfcWeb.FighterController do
  @moduledoc """
  Fighter Controller
  """
  use LfcWeb, :controller

  alias Lfc.Main.Fighter
  alias Lfc.Main
  alias LfcWeb.LayoutView

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
        # email admin
        render conn, "thank_you.html", fighter: fighter
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def thank_you(conn, _params) do
    render conn, "thank_you.html", fighter: nil
  end

end
