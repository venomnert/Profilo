defmodule ProfiloWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :profilo
  use Absinthe.Phoenix.Endpoint

  socket "/socket", ProfiloWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :profilo,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_profilo_key",
    signing_salt: "w8nb8m7D"

  plug Pow.Plug.Session, otp_app: :profilo

  plug ProfiloWeb.Router
end
