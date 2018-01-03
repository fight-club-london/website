defmodule Lfc.Main do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Lfc.{Main}

  # Import modules below
  use Main.FighterApi
  use Main.EventApi
  use Main.ContactApi

end
