ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(RestWebProxy.Repo, :manual)

Mox.defmock(RestWebProxy.HttpClient.ServiceMock, for: RestWebProxy.HttpClient.Behaviour)
