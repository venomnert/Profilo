defmodule ProfiloWeb.PageController do
  use ProfiloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
