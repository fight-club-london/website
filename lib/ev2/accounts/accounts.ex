defmodule Ev2.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Ev2.{Accounts, Repo}


  import Accounts.CacheAPI
  use Accounts.UserAPI



end
