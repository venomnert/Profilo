defmodule ProfiloWeb.UserController do
  use ProfiloWeb, :controller

  alias Profilo.Accounts
  alias Profilo.Accounts.Lib.User

  action_fallback ProfiloWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: ["Authorization": "Bearer ad33f7907bf3458213f9c2f3aebeb435ff016487"])
    result = Neuron.query("""
    {
      viewer {
        name
        following(first: 50) {
          nodes {
            name
            url
            repositories(first: 5, orderBy: {field: UPDATED_AT, direction: DESC}) {
              nodes {
                name
                primaryLanguage {
                  name
                }
                description
                url
                updatedAt
              }
            }
          }
        }
      }
    }
    """)
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user, result: result)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
