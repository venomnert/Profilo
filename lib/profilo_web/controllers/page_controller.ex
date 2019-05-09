defmodule ProfiloWeb.PageController do
  use ProfiloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def twitter(conn, _params) do
    data = ExTwitter.request(:get, "1.1/statuses/home_timeline.json")
    render(conn, "data.json", twitter: data)
  end
end
