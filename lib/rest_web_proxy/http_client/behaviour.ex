defmodule RestWebProxy.HttpClient.Behaviour do
  @moduledoc """
  Behaviour for http client
  """

  @type response :: HTTPoison.Response.t()
  @type error_response :: HTTPoison.Error.t()

  @doc """
  Call URL by GET using provided headers
  """
  @callback get(url :: String.t(), headers :: list) ::
              {:ok, response} | {:error, error_response}
  @doc """
  Call URL by POST using provided params and headers
  """
  @callback post(url :: String.t(), params :: list, headers :: list) ::
              {:ok, response} | {:error, error_response}
end
