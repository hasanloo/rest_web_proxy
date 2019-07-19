defmodule RestWebProxy.HttpClient.Behaviour do
  @type response :: HTTPoison.Response.t()
  @type error_response :: HTTPoison.Error.t()

  @doc """
  Call URL by GET using provided headers
  """
  @callback get(url :: String.t(), headers :: List.t()) ::
              {:ok, response} | {:error, error_response}
  @doc """
  Call URL by POST using provided params and headers
  """
  @callback post(url :: String.t(), params :: List.t(), headers :: List.t()) ::
              {:ok, response} | {:error, error_response}
end
