defmodule RestWebProxyWeb.ProxyController do
  use RestWebProxyWeb, :controller

  import Logger

  def sync_post(conn, %{"proxy" => proxy} = params) do
    proxy_url =
      params
      |> get_params
      |> URI.encode_query()
      |> get_proxy_url(proxy)

    headers = get_headers(conn)
    post_params = get_params(params)

    case HTTPoison.post(proxy_url, {:form, post_params}, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> conn |> send_resp(200, body)
      {:ok, %HTTPoison.Response{status_code: 404}} -> conn |> send_resp(404, "")
      {:error, %HTTPoison.Error{reason: reason}} -> conn |> send_resp(500, reason)
    end
  end

  def sync_get(conn, %{"proxy" => proxy} = params) do
    proxy_url =
      params
      |> get_params
      |> URI.encode_query()
      |> get_proxy_url(proxy)

    headers = get_headers(conn)

    case HTTPoison.get(proxy_url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> conn |> send_resp(200, body)
      {:ok, %HTTPoison.Response{status_code: 404}} -> conn |> send_resp(404, "")
      {:error, %HTTPoison.Error{reason: reason}} -> conn |> send_resp(500, reason)
    end
  end

  def async_post(conn, %{"proxy" => proxy} = params) do
    proxy_url =
      conn.query_string
      |> get_proxy_url(proxy)

    headers = get_headers(conn)
    post_params = get_params(params)

    Task.start(fn ->
      HTTPoison.post(proxy_url, {:form, post_params}, headers)
    end)

    conn
    |> send_resp(200, "OK")
  end

  def async_get(conn, %{"proxy" => proxy} = params) do
    proxy_url =
      params
      |> get_params
      |> URI.encode_query()
      |> get_proxy_url(proxy)

    headers = get_headers(conn)

    Task.start(fn ->
      response = HTTPoison.get(proxy_url, headers)
    end)

    conn
    |> send_resp(200, "OK")
  end

  defp get_url(url, "") do
    url
  end

  defp get_url(url, query_string) do
    url
    |> URI.parse()
    |> merge_query_strings(query_string)
    |> URI.to_string()
  end

  defp merge_query_strings(%{query: query} = uri, query_string) when is_binary(query) do
    uri
    |> Map.update(:query, "", &(&1 <> "&" <> query_string))
  end

  defp merge_query_strings(uri, query_string) do
    uri
    |> Map.update(:query, "", fn _qs -> query_string end)
  end

  defp get_headers(conn) do
    conn.req_headers
    |> Enum.filter(fn {key, value} ->
      !Enum.member?(["content-length", "host", "user-agent"], key)
    end)
  end

  defp get_params(params) do
    params
    |> Enum.filter(fn {key, value} -> !Enum.member?(["proxy"], key) end)
  end

  defp get_proxy_url(params, proxy) do
    proxy_atom = String.to_atom(proxy)

    Application.get_env(:rest_web_proxy, :proxies)[proxy_atom]
    |> get_url(params)
  end
end
