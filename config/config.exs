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


config :profilo, :pow_assent,
  providers: [
    github: [
      client_id: "54fcf4d0d72ec4e8cf15",
      client_secret: "ea2c8bb18819816c0dbf3b993eb5dfdb3e41a2fb",
      strategy: Profilo.Github.Strategy
    ],
    twitter: [
      consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
      consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
      strategy: PowAssent.Strategy.Twitter
    ]
  ]

config :extwitter, :oauth, [
    consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
    consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
    access_token: "4215379283-D0Xr52IQjmOqELLY5BEx8R9Sjx5e6Kb3Xkznnsn",
    access_token_secret: "DX0NPbVA9De8b8jieAE1M2DEwxMBCJzWyPnW37xuiVrAg"
 ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
