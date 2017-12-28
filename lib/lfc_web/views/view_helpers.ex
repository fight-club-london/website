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

  def get_time(date) do
    hour = date.hour
    minute = date.minute
    day = date.day
    month = date.month
    year = date.year
    am_pm =
      case hour > 11 do
        true -> "pm"
        false -> "am"
      end
    "#{day}/#{month}/#{year} #{hour}:#{minute}#{am_pm}"
  end

end