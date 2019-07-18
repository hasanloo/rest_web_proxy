defmodule RestWebProxy.Repo do
  use Ecto.Repo,
    otp_app: :rest_web_proxy,
    adapter: Ecto.Adapters.Postgres
end
