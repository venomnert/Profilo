defmodule Profilo.Github do
  @moduledoc """
  The Github context.
  """

  def get_followers(id) do
    init_github()
    Neuron.query("""
      {
        user(login: "#{id}") {
          following(first: 100) {
            totalCount
            edges {
              node {
                url
                name
              }
              cursor
            }
            pageInfo {
              endCursor
              hasNextPage
            }
          }
        }
      }
    """)
  end

  defp init_github() do
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: ["Authorization": "Bearer ad33f7907bf3458213f9c2f3aebeb435ff016487"])
  end
end
