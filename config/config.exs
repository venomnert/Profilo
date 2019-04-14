# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :profilo,
  ecto_repos: [Profilo.Repo]

# Configures the endpoint
config :profilo, ProfiloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UrVi7s/9fPCQg4v0fbx3lhgAAQeRg7ddbAC8JU4/Wu/p197JRt+eISurz/y4mqP2",
  render_errors: [view: ProfiloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Profilo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# POW authenticaiton
config :profilo, :pow,
  user: Profilo.Accounts.Lib.User,
  repo: Profilo.Repo,
  web_module: ProfiloWeb,
  web_module: MyAppWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
