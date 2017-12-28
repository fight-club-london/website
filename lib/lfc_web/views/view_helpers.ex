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

  def format_long_date(date) do
    day = date.day
    month = find_month(date.month)
    year = Integer.to_string(date.year)
    suffix =
      case day do
        1 -> "st"
        21 -> "st"
        31 -> "st"
        2 -> "nd"
        22 -> "nd"
        3 -> "rd"
        23 -> "rd"
        _other -> "th"
      end
    "#{day}#{suffix} #{month} #{year}"
  end

  def find_month(index) do
    case index do
      1 -> "January"
      2 -> "February"
      3 -> "March"
      4 -> "April"
      5 -> "May"
      6 -> "June"
      7 -> "July"
      8 -> "August"
      9 -> "September"
      10 -> "October"
      11 -> "November"
      12 -> "December"
    end
  end

end
