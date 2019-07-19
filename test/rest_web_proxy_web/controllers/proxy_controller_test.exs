defmodule RestWebProxyWeb.ProxyControllerTest do
  use RestWebProxyWeb.ConnCase

  import Mox
  # @http_service_mock RestWebProxy.HttpClient.ServiceMock

  @valid_attrs %{proxy: "test_noparams"}
  @valid_attrs_with_params %{proxy: "test"}
  @request_params %{
    transfer_amount: 100,
    destination_account: "d0b0548b-4d09-475f-b6a4-bbb55a21cf7e"
  }
  @expected_request_params {:form,
                            [
                              {"destination_account", "d0b0548b-4d09-475f-b6a4-bbb55a21cf7e"},
                              {"transfer_amount", 100}
                            ]}

  @http_response_success {:ok,
                          %HTTPoison.Response{
                            body: "{\"success\": true}",
                            headers: [
                              {"Connection", "keep-alive"},
                              {"Server", "Cowboy"},
                              {"Date", "Sat, 06 Jun 2015 03:52:13 GMT"},
                              {"Content-Length", "495"},
                              {"Content-Type", "application/json"},
                              {"Via", "1.1 vegur"}
                            ],
                            status_code: 200
                          }}

  setup :set_mox_global
  setup :verify_on_exit!

  describe "sync_post/2" do
    test "Call proxy endpoint without params synchronously", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:post, fn _, _, _ -> @http_response_success end)

      conn = post(conn, Routes.proxy_path(conn, :sync_post, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params synchronously with params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :post,
        fn "https://en8m2ly5vtjxa.x.pipedream.net?destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           @expected_request_params,
           _ ->
          @http_response_success
        end
      )

      conn = post(conn, Routes.proxy_path(conn, :sync_post, @valid_attrs.proxy), @request_params)

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint with params synchronously with params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :post,
        fn "https://en8m2ly5vtjxa.x.pipedream.net/?test=123&destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           @expected_request_params,
           _ ->
          @http_response_success
        end
      )

      conn =
        post(
          conn,
          Routes.proxy_path(conn, :sync_post, @valid_attrs_with_params.proxy),
          @request_params
        )

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params synchronously with headers", %{
      conn: _conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:post, fn _, _, [{"content-type", "application/json"}, {"test", "123"}] ->
        @http_response_success
      end)

      conn =
        build_conn()
        |> put_req_header("content-type", "application/json")
        |> put_req_header("test", "123")

      conn = post(conn, Routes.proxy_path(conn, :sync_post, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end
  end

  describe "async_post/2" do
    test "Call proxy endpoint without params asynchronously", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:post, fn _, _, _ -> @http_response_success end)

      conn = post(conn, Routes.proxy_path(conn, :async_post, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params asynchronously with post params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :post,
        fn "https://en8m2ly5vtjxa.x.pipedream.net?destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           @expected_request_params,
           _ ->
          @http_response_success
        end
      )

      conn = post(conn, Routes.proxy_path(conn, :async_post, @valid_attrs.proxy), @request_params)

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint with params asynchronously with params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :post,
        fn "https://en8m2ly5vtjxa.x.pipedream.net/?test=123&destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           @expected_request_params,
           _ ->
          @http_response_success
        end
      )

      conn =
        post(
          conn,
          Routes.proxy_path(conn, :async_post, @valid_attrs_with_params.proxy),
          @request_params
        )

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params synchronously with headers", %{
      conn: _conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:post, fn _, _, [{"content-type", "application/json"}, {"test", "123"}] ->
        @http_response_success
      end)

      conn =
        build_conn()
        |> put_req_header("content-type", "application/json")
        |> put_req_header("test", "123")

      conn = post(conn, Routes.proxy_path(conn, :async_post, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end
  end

  describe "sync_get/2" do
    test "Call proxy endpoint without params synchronously", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:get, fn _, _ -> @http_response_success end)

      conn = get(conn, Routes.proxy_path(conn, :sync_get, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params synchronously with get params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :get,
        fn "https://en8m2ly5vtjxa.x.pipedream.net?destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           _ ->
          @http_response_success
        end
      )

      conn = get(conn, Routes.proxy_path(conn, :sync_get, @valid_attrs.proxy), @request_params)

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint with params synchronously with get params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :get,
        fn "https://en8m2ly5vtjxa.x.pipedream.net/?test=123&destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           _ ->
          @http_response_success
        end
      )

      conn =
        get(
          conn,
          Routes.proxy_path(conn, :sync_get, @valid_attrs_with_params.proxy),
          @request_params
        )

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params synchronously with headers", %{
      conn: _conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:get, fn _, [{"content-type", "application/json"}, {"test", "123"}] ->
        @http_response_success
      end)

      conn =
        build_conn()
        |> put_req_header("content-type", "application/json")
        |> put_req_header("test", "123")

      conn = get(conn, Routes.proxy_path(conn, :sync_get, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end
  end

  describe "async_get/2" do
    test "Call proxy endpoint without params synchronously", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:get, fn _, _ -> @http_response_success end)

      conn = get(conn, Routes.proxy_path(conn, :async_get, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params asynchronously with get params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :get,
        fn "https://en8m2ly5vtjxa.x.pipedream.net?destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           _ ->
          @http_response_success
        end
      )

      conn = get(conn, Routes.proxy_path(conn, :async_get, @valid_attrs.proxy), @request_params)

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint with params asynchronously with get params", %{
      conn: conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(
        :get,
        fn "https://en8m2ly5vtjxa.x.pipedream.net/?test=123&destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&transfer_amount=100",
           _ ->
          @http_response_success
        end
      )

      conn =
        get(
          conn,
          Routes.proxy_path(conn, :sync_get, @valid_attrs_with_params.proxy),
          @request_params
        )

      assert true = json_response(conn, 200)["success"]
    end

    test "Call proxy endpoint without params asynchronously with headers", %{
      conn: _conn
    } do
      RestWebProxy.HttpClient.ServiceMock
      |> expect(:get, fn _, [{"content-type", "application/json"}, {"test", "123"}] ->
        @http_response_success
      end)

      conn =
        build_conn()
        |> put_req_header("content-type", "application/json")
        |> put_req_header("test", "123")

      conn = get(conn, Routes.proxy_path(conn, :sync_get, @valid_attrs.proxy))

      assert true = json_response(conn, 200)["success"]
    end
  end
end
