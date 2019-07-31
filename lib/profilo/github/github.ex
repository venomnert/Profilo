defmodule Profilo.Github do
  @moduledoc """
  The Github context.
  """
  alias Profilo.{Entity, Accounts}
  alias Profilo.Accounts.Lib.User
  alias Profilo.Entity.Lib.{Profile}

  @update_query """
    {
      viewer{
        following(first: 20) {
          totalCount
          nodes {
            login
            avatarUrl
            name
            starredRepositories(first: 5, orderBy:{field:STARRED_AT, direction: DESC}) {
              edges {
                starredAt
                node {
                  name
                  url
                }
              }
            }
            watching(first: 5, orderBy:{field:UPDATED_AT, direction: DESC}) {
              edges {
                node {
                  name
                  url
                }
              }
            }
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
  """
  @update_next_query """
    query($cursor: String){
      viewer {
          following(first: 20, after: $cursor) {
          totalCount
          nodes {
            login
            avatarUrl
            name
            starredRepositories(first: 5, orderBy:{field:STARRED_AT, direction: DESC}) {
              edges {
                starredAt
                node {
                  name
                  url
                }
              }
            }
            watching(first: 5, orderBy:{field:UPDATED_AT, direction: DESC}) {
              edges {
                node {
                  name
                  url
                }
              }
            }
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
  """

  @retrieve_followings    ["data", "viewer", "following", "nodes"]
  @retreive_next_page     ["data", "viewer", "following", "pageInfo", "hasNextPage"]
  @retreive_end_cursor    ["data", "viewer", "following", "pageInfo", "endCursor"]

  def get_update(%User{} = user) do
    init_github(user)
    Neuron.query(@update_query)
    |> case do
      {:ok, %Neuron.Response{} = result}   -> get_in(result.body, @retreive_next_page) |> handle_success_result(user, result)
      {:error, %Neuron.Response{} = error} -> error.body
      {:error, %HTTPoison.Error{} = error} -> error.reason
    end
  end

  def handle_success_result(false, user, result) do
    Enum.any?(result.body["data"])
    |> case do
      true -> handle_success_result(true, user, result)
      false -> user
    end
  end

  def handle_success_result(true, user, result) do
    get_in(result.body, @retrieve_followings)
    |> add_followings_to_profilo(user)
    |> add_feed_node_to_profilo(user)

    get_next_data(user, get_in(result.body, @retreive_end_cursor))
  end

  ########### Create following ###########
  def add_followings_to_profilo(data, %User{} = user) do
    data
    |> Enum.each(fn single_following ->
      case Entity.create_github_following(user, single_following) do
        {:ok, _} -> "Following created"
        {:error, %Ecto.Changeset{}} -> "Following already exisits"
      end
    end)

    data
  end

  ########### Create feed node ###########
  def add_feed_node_to_profilo(data, %User{} = user) do
    Entity.get_profiles_by_social_link(user, "github")
    |> Enum.each(fn profile ->
        profile
        |> get_following_by_social_link(user, "github")
        |> get_node_by_following(data)
        |> add_starred_repos(profile, user)
        |> add_watched_repo(profile, user)
      end)

    data
  end

  defp get_following_by_social_link(profile, user, social_link) do
    Entity.get_following_by_social_link(user, profile, social_link)
  end

  defp get_node_by_following(github_followings, data) do
    github_followings
    |> Enum.map(fn following ->
        data
        |> Enum.filter(fn following_node ->
          following_node["login"] == following.screen_name
        end)
      end)
    |> List.flatten()
  end

  defp add_starred_repos(nil, %Profile{} = _profile, %User{} = _user), do: %{}
  defp add_starred_repos(nodes, %Profile{} = profile, %User{} = user) do
    nodes
    |> Enum.each(fn node ->
      data = node["starredRepositories"]["edges"] |> List.first()
      attr = %{description: "starred #{data["node"]["url"]} at #{data["starredAt"]}"}
      Entity.create_github_feed_node(user, profile, attr)
    end)

    nodes
  end

  defp add_watched_repo(nil, %Profile{} = _profile, %User{} = _user), do: %{}
  defp add_watched_repo(nodes, %Profile{} = profile, %User{} = user) do
    nodes
    |> Enum.each(fn node ->
      data = node["watching"]["edges"] |> List.first()
      attr = %{description: "watching #{data["node"]["url"]}"}
      Entity.create_github_feed_node(user, profile, attr)
    end)
    nodes
  end


  ########### Retrieve next set of data from Github ###########
  def get_next_data(%User{} = user, cursor) do
    Neuron.query(@update_next_query, %{cursor: cursor})
    |> case do
      {:ok, %Neuron.Response{} = result}    -> get_in(result.body, @retreive_next_page) |> handle_success_result(user, result)
      {:error, %HTTPoison.Error{} = error}  -> {:error, %{message: error.reason}}
    end
  end

  ########### Github Config ###########
  defp init_github(%User{} = user) do
    user_identity = Accounts.get_user_identity!(user, "github")
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: ["Authorization": "Bearer #{user_identity.access_token}"])
  end
end
