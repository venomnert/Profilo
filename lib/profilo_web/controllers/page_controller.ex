defmodule ProfiloWeb.PageController do
  use ProfiloWeb, :controller

  alias Profilo.Accounts
  alias Profilo.Accounts.Lib.UserIdentity

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def twitter(conn, _params) do
    %UserIdentity{} = user = Accounts.get_user_identity!(conn.assigns.current_user, "twitter")

    ExTwitter.configure(:process, [
      consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
      consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
      access_token: user.oauth_token,
      access_token_secret: user.oauth_token_secret
    ])
    data = ExTwitter.request(:get, "1.1/statuses/home_timeline.json")
    render(conn, "data.json", twitter: data)
  end

  def github(conn, _params) do
    user = Accounts.get_user_identity!(conn.assigns.current_user, "github")
            |> Map.drop([:__meta__, :inserted_at, :user])
    IO.inspect(user, label: "GITHUB USER")
    render(conn, "user.json", data: user)
  end
end
