defmodule Profilo.Application do

  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      Profilo.Repo,
      ProfiloWeb.Endpoint,
      supervisor(Absinthe.Subscription, [ProfiloWeb.Endpoint])
    ]

    opts = [strategy: :one_for_one, name: Profilo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ProfiloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
