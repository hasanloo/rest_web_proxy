defmodule RestWebProxy.HttpClient.Service do
  @behaviour RestWebProxy.HttpClient.Behaviour

  def get(url, headers \\ []) do
    HTTPoison.get(url, headers)
  end

  def post(url, params \\ [], headers \\ []) do
    HTTPoison.post(url, params, headers)
  end
end
