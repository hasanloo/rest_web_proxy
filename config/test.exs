use Mix.Config

# Configure your database
config :rest_web_proxy, RestWebProxy.Repo,
  username: "postgres",
  password: "",
  database: "rest_web_proxy_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rest_web_proxy, RestWebProxyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :rest_web_proxy, :http_client, RestWebProxy.HttpClient.ServiceMock

config :rest_web_proxy, :proxies,
  test_noparams: "https://en8m2ly5vtjxa.x.pipedream.net",
  test: "https://en8m2ly5vtjxa.x.pipedream.net/?test=123"
