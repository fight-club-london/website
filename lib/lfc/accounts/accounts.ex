defmodule Lfc.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Lfc.{Accounts}

  # Import modules below
  use Accounts.CacheAPI
  use Accounts.UserAPI

end
