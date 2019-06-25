defmodule ProfiloWeb.PageController do
  use ProfiloWeb, :controller

  alias Profilo.Accounts
  alias Profilo.Accounts.Lib.User

  alias Profilo.Twitter

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def uikit(conn, _params) do
    render(conn, "uikit.html")
  end

  def get_user(conn, %{"provider" => provider}) do
    data = get_user_from_provider(String.to_atom(provider), conn.assigns.current_user)
    case data do
      {:error, message} ->
        conn
        |> put_status(404)
        |> render( "error.json", data: message)
      {:ok, data} -> render(conn, "data.json", data: data)
    end
  end

  def is_auth(conn, %{"provider" => provider}) do
    data = Accounts.get_user_identity!(conn.assigns.current_user, provider)
    render(conn, "user.json", user: data)
  end

  defp get_user_from_provider(:twitter, %User{} = curr_user) do
    Accounts.get_user_identity!(curr_user, "twitter")
    |> Twitter.get_timeline()
  end

  defp get_user_from_provider(_, %User{} = _curr_user) do
    {:error, "no provider"}
  end
end
