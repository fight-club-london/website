defmodule Ev2.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Ev2.{Accounts, Repo}


  use Accounts.CacheAPI
  use Accounts.UserAPI



end
