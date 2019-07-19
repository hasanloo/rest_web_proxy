defmodule RestWebProxy.HttpClient.Service do
  @moduledoc """
  Http client service
  """

  @behaviour RestWebProxy.HttpClient.Behaviour

  def get(url, headers \\ []) do
    HTTPoison.get(url, headers)
  end

  def post(url, params \\ [], headers \\ []) do
    HTTPoison.post(url, params, headers)
  end
end
