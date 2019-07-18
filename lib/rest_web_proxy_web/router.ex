defmodule RestWebProxyWeb.Router do
  use RestWebProxyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestWebProxyWeb do
    pipe_through :api

    post "/sync/:proxy", ProxyController, :sync_post
    post "/async/:proxy", ProxyController, :async_post
    get "/sync/:proxy", ProxyController, :sync_get
    get "/async/:proxy", ProxyController, :async_get
  end
end
