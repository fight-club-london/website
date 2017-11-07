defmodule Ev2.RedisClientSupervisor do
  use Supervisor

  alias Ev2.Accounts.Cache

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Cache, [System.get_env("REDIS_URL"), :redix], [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
