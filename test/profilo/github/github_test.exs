defmodule Profilo.GithubTest do
  use Profilo.DataCase

  alias Profilo.Github
  alias Profilo.Entity
  alias Profilo.Entity.Lib.{Following, Profile, SocialLink}
  alias Profilo.Test.UserTestHelper

  @valid__user_attrs %{
    email: "test@gmail.com",
    password: "1234567890",
    current_password: "1234567890",
    confirm_password: "1234567890",
    address: "some address",
    company: "some company",
    first_name: "some first_name",
    last_name: "some last_name",
    phone_number: "some phone_number",
    website: "some website"
  }
  @valid_profile_attrs %{
    name: "Kyle Simpson",
    avatar_url: "https://profilo.app"
  }
  @valid_following_attrs %{
    name: "Kyle Simpson",
    avatar_url: "https://avatars2.githubusercontent.com/u/577441?v=4",
    screen_name: "getify"
  }
  @valid_social_link_attrs %{
    name: "github",
  }
  @valid_github_api_data %{
    :body => %{
      "data" => %{
        "viewer" => %{
          "following" => %{
            "nodes" => [
              %{
                "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
                "login" => "getify",
                "name" => "Kyle Simpson",
                "starredRepositories" => %{
                  "edges" => [
                    %{
                      "node" => %{
                        "name" => "knex",
                        "url" => "https://github.com/tgriesser/knex"
                      },
                      "starredAt" => "2019-07-14T16:49:19Z"
                    }
                  ]
                },
                "watching" => %{
                  "edges" => [
                    %{
                      "node" => %{
                        "name" => "You-Dont-Know-JS",
                        "url" => "https://github.com/getify/You-Dont-Know-JS"
                      }
                    }
                  ]
                }
              },
              %{
                "avatarUrl" => "https://avatars2.githubusercontent.com/u/577441?v=4",
                "login" => "exAspArk",
                "name" => nil,
                "starredRepositories" => %{
                  "edges" => [
                    %{
                      "node" => %{
                        "name" => "ams_lazy_relationships",
                        "url" => "https://github.com/Bajena/ams_lazy_relationships"
                      },
                      "starredAt" => "2019-03-08T15:44:22Z"
                    }
                  ]
                },
                "watching" => %{
                  "edges" => [
                    %{
                      "node" => %{
                        "name" => "graphql-errors",
                        "url" => "https://github.com/exAspArk/graphql-errors"
                      }
                    }
                  ]
                }
              }
            ],
            "pageInfo" => %{
              "endCursor" => "Y3Vyc29yOnYyOpK5MjAxOS0wNi0xN1QxOTo1Mjo0My0wNDowMM4Cvp7y",
              "hasNextPage" => true
            },
            "totalCount" => 22
          }
        }
      }
    }
  }
  @retrieve_followings    ["data", "viewer", "following", "nodes"]

  setup do
    user = UserTestHelper.user_fixture(@valid__user_attrs)
    {:ok, user: user}
  end

  test "handle_success_result/3 update following and feed", state do
    {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
    {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
    {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)
    Entity.add_following_to_profile(state[:user], profile, following)

    test_handle_success_result(true, state[:user], @valid_github_api_data)

    assert length(Entity.list_profile_feed_node(state[:user], profile)) > 0

  end

  defp test_handle_success_result(true, user, result) do
    get_in(result.body, @retrieve_followings)
    |> Github.add_followings_to_profilo(user)
    |> Github.add_feed_node_to_profilo(user)
  end
end
