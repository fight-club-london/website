defmodule Lfc.Utils do
  @moduledoc """
  Utils for Lfc
  """

  @doc """
  Generates a random string of chosen length if specified

  ## Examples

      iex> gen_rand_string(5)
      "d93n4"

  """
  def gen_rand_string(length \\ 10) do
    crypto = :crypto.strong_rand_bytes(length)

    crypto
    |> Base.url_encode64()
    |> binary_part(0, length)
  end

  @doc """
  Returns the base URL of the environment you are currently in

  ## Examples

      iex> get_base_url()
      "http://localhost:4000"

  """
  def get_base_url do
    dev_env? = Mix.env == :dev
    case dev_env? do
      true -> System.get_env("DEV_URL")
      false -> System.get_env("PROD_URL")
    end
  end

end
