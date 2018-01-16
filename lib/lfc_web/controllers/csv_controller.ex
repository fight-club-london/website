defmodule LfcWeb.CsvController do
  @moduledoc """
  Contact Controller
  """
  use LfcWeb, :controller

  alias Lfc.Main.Contact
  alias Lfc.Main
  alias LfcWeb.ViewHelpers

  def export_fighters(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"fighter_data.csv\"")
    |> send_resp(200, csv_fighter_content)
  end

  defp csv_fighter_content do
    header = [
      [
        "Title",
        "First name",
        "Last name",
        "Email",
        "Mobile number",
        "Location",
        "Occupation",
        "Signed up"
      ]
    ]
    fighters =
      Main.list_fighters()
      |> Enum.map(fn fighter -> Map.from_struct(fighter) end)
      |> Enum.map(fn fighter -> [
        fighter.title,
        fighter.first_name,
        fighter.last_name,
        fighter.email,
        fighter.mobile_number,
        fighter.location,
        fighter.occupation,
        ViewHelpers.get_time(fighter.inserted_at)
      ] end)
    content = header ++ fighters
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end

end
