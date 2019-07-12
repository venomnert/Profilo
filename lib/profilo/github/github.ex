defmodule Profilo.Github do
  @moduledoc """
  The Github context.
  """
  alias Profilo.Entity
  alias Profilo.Accounts.Lib.User

  def get_followers(%User{} = user) do
    init_github()
    {:ok, %Neuron.Response{} = result} = Neuron.query("""
    {
      viewer {
          following(first: 20) {
          totalCount
            edges {
              node {
                avatarUrl
                name
                isHireable
              }
            }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
    """)
    result.body["data"]["viewer"]["following"]["edges"]
    |> add_followings_to_profilo(user)

    result.body["data"]["viewer"]["following"]["pageInfo"]["hasNextPage"]
    |> get_next_followers(user, result.body["data"]["viewer"]["following"]["pageInfo"]["endCursor"])
  end

  def get_next_followers(false, %User{} = _user, _cursor), do: false
  def get_next_followers(true, %User{} = user, cursor) do
    {:ok, %Neuron.Response{} = result} = Neuron.query("""
    {
      viewer {
          following(first: 20, after: "#{cursor}") {
          totalCount
            edges {
              node {
                avatarUrl
                name
                isHireable
              }
            }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
    """)
    result.body["data"]["viewer"]["following"]["edges"]
    |> add_followings_to_profilo(user)

    result.body["data"]["viewer"]["following"]["pageInfo"]["hasNextPage"]
    |> get_next_followers(user, result.body["data"]["viewer"]["following"]["pageInfo"]["endCursor"])
  end

  defp init_github() do
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: ["Authorization": "Bearer 7b06bd9125cdace640267a059391a83baff1f4dc"])
  end

  defp add_followings_to_profilo(data, %User{} = user) do
    data
    |> Enum.each(fn %{"node" => %{"name" => name, "avatarUrl" => avatarUrl}} ->
      social_link = Entity.get_social_link("github")
      attrs = %{name: name, avatar_url: avatarUrl}
      case Entity.create_following(user, social_link, attrs) do
        {:ok, _} -> "Following created"
        {:error, %Ecto.Changeset{}} -> "Following already exisits"
      end
    end)
  end
end
