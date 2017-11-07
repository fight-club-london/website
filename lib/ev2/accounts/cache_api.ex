defmodule Ev2.Accounts.CacheAPI do
  defmacro __using__(_) do
    quote do
      alias Ev2.{Accounts.Cache}

      def get_target_email(target_email_hash) do
        case Cache.query(["GET", target_email_hash]) do
          {:ok, nil} -> nil
          {:ok, email} -> email
        end
      end
      
    end
  end
end
