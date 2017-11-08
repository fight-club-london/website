defmodule Ev2.Accounts.CacheAPI do

  @moduledoc """
  Provides an API for cache functionality
  """
  defmacro __using__(_) do
    quote do
      alias Ev2.{Accounts.Cache, Utils}

      @doc """
      Returns email from cache if it exists.

      ## Examples

          iex> get_target_email(hash)
          joebloggs@email.com

      """
      def get_target_email(target_email_hash) do
        case Cache.query(["GET", target_email_hash]) do
          {:ok, nil} -> nil
          {:ok, email} -> email
        end
      end

      @doc """
      Sets an email as a value for a random string and returns the string

      ## Examples

          iex> set_as_value(email)
          {:ok, "OK"}

      """
      def set_as_value(email) do
        rand_string = Utils.gen_rand_string(30)
        Cache.query(["SET", rand_string, email])
        rand_string
      end

      @doc """
      Gets an email from a redis hash

      ## Examples

          iex> get_email_from_hash(hash)
          {:ok, "example@email.com"}

      """

      def get_email_from_hash(hash) do
        case Cache.get(hash) do
          {:ok, nil} -> {:error, "User not in Redis"}
          {:ok, email} -> {:ok, email}
        end
      end

    end
  end
end
