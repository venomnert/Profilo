defmodule ProfiloWeb.Schema.Query.QueryTest do
  use ProfiloWeb.ConnCase, async: true

  alias Profilo.Entity
  alias Profilo.Entity.Lib.SocialLink
  alias Profilo.Test.UserTestHelper
  alias ProfiloWeb.Schema

  @github_following [
    %{
      "node" => %{
        "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
        "isHireable" => true,
        "name" => "Kyle Simpson"
      }
    }
  ]

  @profiles [
    %{
      "name" => "Kyle Simpson",
      "avatar_url" => "https://profilo.app"
    }
  ]
  @update_profiles %{
    "Kyle Simpson" => %{
      "following" => "Kyle Simpson"
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
    name: "github",
  }

  @followings_query """
  {
    followings {
      name
      avatarUrl
      socialLinkId
    }
  }
  """
  @following_query """
  {
    following(name: "Kyle Simpson") {
      name
      avatarUrl
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
      }
    }
  }
  """
  @profile_query """
  {
    profile(name: "Kyle Simpson") {
      name
      followings {
        name
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

  setup do
    user = UserTestHelper.user_fixture(@valid_user_attrs)
    {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

    @github_following
    |> Enum.each(fn %{"node" => %{"name" => name, "avatarUrl" => avatarUrl}} ->
      attrs = %{name: name, avatar_url: avatarUrl}
      case Entity.create_following(user, social_link, attrs) do
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
    {:ok, %{data: %{"followings" => returned_followings}}} = Absinthe.run(@followings_query, Schema, context: state[:context])

    assert returned_followings == [
                                    %{
                                      "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
                                      "name" => "Kyle Simpson",
                                      "socialLinkId" => "#{state[:social_link].id}"
                                    }
                                  ]
  end

  test "following field returns specific following items", state do

    {:ok, %{data: %{"following" => returned_following}}} = Absinthe.run(@following_query, Schema, context: state[:context])

    assert returned_following == %{
                                  "name" => "Kyle Simpson",
                                  "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
                                  "socialLinkId" => "#{state[:social_link].id}"
                                }
  end

  test "profiles field returns profile items and associated following item", state do

    {:ok, %{data: %{"profiles" => returned_profiles}}} = Absinthe.run(@profiles_query, Schema, context: state[:context])

    assert returned_profiles == [
                                  %{
                                    "name" => "Kyle Simpson",
                                    "followings" => [
                                      %{
                                        "name" => "Kyle Simpson"
                                      }
                                    ],
                                  }
                                ]
  end

  test "profile field returns specific profile items and associated following items", state do

    {:ok, %{data: %{"profile" => returned_profile}}} = Absinthe.run(@profile_query, Schema, context: state[:context])

    assert returned_profile == %{
                                  "name" => "Kyle Simpson",
                                  "followings" => [
                                    %{
                                      "name" => "Kyle Simpson"
                                    }
                                  ],
                                }
  end

  test "social_links field returns social_link items", state do
    {:ok, %{data: %{"socialLinks" => returned_social_links}}} = Absinthe.run(@social_links_query, Schema, context: state[:context])

    assert returned_social_links == [
                                      %{ "name" => "github" }
                                    ]
  end

end
