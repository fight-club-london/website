defmodule LfcWeb.ViewHelpers do
  @moduledoc """
  view helper functions
  """
  def this_month(fighters) do
    year = DateTime.utc_now.year
    month = DateTime.utc_now.month

    fighters
    |> Enum.filter(fn fighter -> fighter.inserted_at.year == year end)
    |> Enum.filter(fn fighter -> fighter.inserted_at.month == month end)
    |> length()
  end
end
