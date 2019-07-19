defmodule ProfiloWeb.Schema.Query.QueryTest do
  use ProfiloWeb.ConnCase, async: true

  alias Profilo.Entity
  alias Profilo.Entity.Lib.SocialLink
  alias Profilo.Test.UserTestHelper
  alias ProfiloWeb.Schema

  @name "Kyle Simpson"
  @screen_name "getify"
  @social_link "github"

  @github_following [
    %{
      "node" => %{
        "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
        "name" => "#{@name}",
        "login" => "#{@screen_name}"
      }
    }
  ]
  @github_feed_node [
    %{"description" => "this is a test"}
  ]
  @profiles [
    %{
      "name" => "#{@name}",
      "avatar_url" => "https://profilo.app"
    }
  ]


  @update_profiles %{
    "Kyle Simpson" => %{
      "following" => "#{@name}"
    }
  }

  @valid_user_attrs %{
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
  @valid_social_link_attrs %{
    name: "#{@social_link}",
  }

  @followings_by_user_query """
  {
    followings {
      name
      avatarUrl
      screenName
      socialLinkId
    }
  }
  """
  @followings_by_profile_query"""
  {
    followings(profileName: "#{@name}") {
      name
      screenName
    }
  }
  """

  @following_query """
  {
    following(name: "#{@name}") {
      name
      avatarUrl
      screenName
      socialLinkId
    }
  }
  """

  @profiles_query """
  {
    profiles {
      name
      followings {
        name
        screenName
      }
    }
  }
  """
  @profile_query """
  query($name: String) {
    profile(name: $name) {
      name
      followings {
        name
        screenName
      }
    }
  }
  """

  @social_links_query """
  {
    socialLinks {
      name
    }
  }
  """

  @feed_nodes_by_profile_query """
  query($id: Int){
    feedNodes(profileId: $id){
       description
   }
  }
  """
  @feed_nodes_by_social_link_query """
  query($name: String){
    feedNodes(socialLinkName: $name){
       description
   }
  }
  """
  @feed_node_query """
  query($id: Int) {
    feedNode(id: $id) {
      description
      profile { name }
      socialLink { name }
    }
  }
  """

  setup do
    user = UserTestHelper.user_fixture(@valid_user_attrs)
    {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

    @github_following
    |> Enum.each(fn single_following ->
      case Entity.create_github_following(user, single_following) do
        {:ok, _} -> "Following created"
        {:error, %Ecto.Changeset{}} -> "Following already exisits"
      end
    end)

    @profiles
    |> Enum.each(fn attr ->
      {:ok, profile } = Entity.create_profile(user, attr)
      following = Entity.get_following(user, @update_profiles[attr["name"]]["following"])
      Entity.add_following_to_profile(user, profile, following)
    end)

    @github_feed_node
    |> Enum.each(fn single_feed_node ->
      profile = Entity.get_profile(user, "#{@name}")
      case Entity.create_github_feed_node(user, profile, single_feed_node) do
        {:ok, _} -> "Feed_node created"
        {:error, %Ecto.Changeset{}} -> "Feed_node already exisits"
      end
    end)

    conn = build_conn()
            |> Map.put(:assigns, %{current_user: user})

    context = %{current_user: conn.assigns.current_user}

    {:ok,
      conn: conn,
      social_link: social_link,
      context: context
    }
  end

  test "followings field returns following items", state do
    {:ok, %{data: %{"followings" => returned_followings}}} = Absinthe.run(@followings_by_user_query, Schema, context: state[:context])

    assert returned_followings == [
                                    %{
                                      "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
                                      "name" => "#{@name}",
                                      "screenName" => "#{@screen_name}",
                                      "socialLinkId" => "#{state[:social_link].id}"
                                    }
                                  ]
  end

  test "followings field returns following items by profile", state do
    {:ok, %{data: %{"followings" => returned_followings}}} = Absinthe.run(@followings_by_profile_query, Schema, context: state[:context])

    assert returned_followings == [
                                    %{
                                      "name" => "#{@name}",
                                      "screenName" => "#{@screen_name}"
                                    }
                                  ]
  end

  test "following field returns specific following item", state do

    {:ok, %{data: %{"following" => returned_following}}} = Absinthe.run(@following_query, Schema, context: state[:context])

    assert returned_following == %{
                                  "name" => "#{@name}",
                                  "screenName" => "#{@screen_name}",
                                  "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
                                  "socialLinkId" => "#{state[:social_link].id}"
                                }
  end

  test "profiles field returns profile items and associated following item", state do

    {:ok, %{data: %{"profiles" => returned_profiles}}} = Absinthe.run(@profiles_query, Schema, context: state[:context])

    assert returned_profiles == [
                                  %{
                                    "name" => "#{@name}",
                                    "followings" => [
                                      %{
                                        "name" => "#{@name}",
                                        "screenName" => "#{@screen_name}"
                                      }
                                    ],
                                  }
                                ]
  end

  test "profile field returns specific profile items and associated following items", state do

    {:ok, %{data: %{"profile" => returned_profile}}} = Absinthe.run(@profile_query, Schema, variables: %{"name" => "#{@name}"}, context: state[:context])

    assert returned_profile == %{
                                  "name" => "#{@name}",
                                  "followings" => [
                                    %{
                                      "name" => "#{@name}",
                                      "screenName" => "#{@screen_name}"
                                    }
                                  ],
                                }
  end

  test "social_links field returns social_link items", state do
    {:ok, %{data: %{"socialLinks" => returned_social_links}}} = Absinthe.run(@social_links_query, Schema, context: state[:context])

    assert returned_social_links == [
                                      %{ "name" => "#{@social_link}" }
                                    ]
  end

  test "feed_node field returns specific feed_node item", state do
    [first_feed_node | _ ]= state[:context].current_user
    |> Entity.list_social_link_feed_node(Entity.get_social_link("#{@social_link}"))

    {:ok, %{data: %{"feedNode" => returned_feed_node}}} = Absinthe.run(@feed_node_query, Schema, variables: %{"id" => first_feed_node.id}, context: state[:context])

    assert returned_feed_node == %{
                                    "description" => "this is a test",
                                    "profile" => %{ "name" => "#{@name}" },
                                    "socialLink" => %{ "name" => "#{@social_link}" }
                                  }
  end

  test "feed_nodes field returns feed_node items by profile", state do
    profile= state[:context].current_user
              |> Entity.get_profile("#{@name}")

    {:ok, %{data: %{"feedNodes" => returned_feed_node}}} = Absinthe.run(@feed_nodes_by_profile_query, Schema, variables: %{"id" => profile.id}, context: state[:context])

    assert returned_feed_node == [%{
                                    "description" => "this is a test"
                                  }]
  end

  test "feed_nodes field returns feed_node items by social_link", state do
    {:ok, %{data: %{"feedNodes" => returned_feed_node}}} = Absinthe.run(@feed_nodes_by_social_link_query, Schema, variables: %{"name" => "#{@social_link}"}, context: state[:context])

    assert returned_feed_node == [%{
                                    "description" => "this is a test"
                                  }]
  end

end
