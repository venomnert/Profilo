defmodule ProfiloWeb.Schema.Mutation.MutationTest do
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

  @profile %{
    "name" => "Kyle Simpson",
    "avatar_url" => "https://profilo.app"
  }
  @update_profile %{
    "name" => "Changed Simpson",
    "avatar_url" => "https://google.com"
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

  @profiles_create_mutation """
  mutation CreateProfile($profile: ProfileInput!) {
    createProfile(input: $profile) {
      name
    }
  }
  """
  @profiles_create_id_mutation """
  mutation CreateProfile($profile: ProfileInput!) {
    createProfile(input: $profile) {
      name
      id
    }
  }
  """

  @profiles_update_mutation """
  mutation UpdateProfile($id: Int!, $profile: ProfileInput!) {
    updateProfile(id: $id, input: $profile) {
      name
      avatarUrl
    }
  }
  """
  @profiles_link_following_mutation """
  mutation UpdateProfile($id: Int!, $following_ids: [Int]!) {
    linkFollowingToProfile(id: $id, followings: $following_ids) {
      name
      avatarUrl
      followings {
        name
      }
    }
  }
  """
  @profiles_unlink_following_mutation """
  mutation UnlinkFollowingToProfile($id: Int!, $following_ids: [Int]!) {
    unlinkFollowingToProfile(id: $id, followings: $following_ids) {
      name
      avatarUrl
      followings {
        name
      }
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

    conn = build_conn()
            |> Map.put(:assigns, %{current_user: user})

    context = %{current_user: conn.assigns.current_user}

    {:ok,
      conn: conn,
      social_link: social_link,
      context: context
    }
  end

  test "create profile", state do
    {:ok, %{data: %{"createProfile" => returned_profile}}} = Absinthe.run(@profiles_create_mutation, Schema, variables: %{"profile" => @profile}, context: state[:context])

    assert returned_profile == %{ "name" => "Kyle Simpson"}

  end

  test "update profile", state do
    {:ok, %{data: %{"createProfile" => profile}}} = Absinthe.run(@profiles_create_id_mutation, Schema, variables: %{"profile" => @profile}, context: state[:context])
    profile_id = profile["id"] |> String.to_integer()

    {:ok, %{data: %{"updateProfile" => update_profile}}} = Absinthe.run(@profiles_update_mutation, Schema, variables: %{"id" => profile_id, "profile" => @update_profile}, context: state[:context])

    assert update_profile == %{
                                "name" => "Changed Simpson",
                                "avatarUrl" => "https://google.com"
                              }

  end

  test "link following to profile", state do
    {:ok, %{data: %{"createProfile" => profile}}} = Absinthe.run(@profiles_create_id_mutation, Schema, variables: %{"profile" => @profile}, context: state[:context])
    profile_id = profile["id"] |> String.to_integer()
    following_ids = [Entity.get_following(state[:context].current_user, "Kyle Simpson").id]

    {:ok, %{data: %{"linkFollowingToProfile" => linked_profile}}} = Absinthe.run(@profiles_link_following_mutation, Schema, variables: %{"id" => profile_id, "following_ids" => following_ids}, context: state[:context])

    assert linked_profile == %{
                                "name" => "Kyle Simpson",
                                "avatarUrl" => "https://profilo.app",
                                "followings" => [
                                  %{ "name" => "Kyle Simpson" }
                                ]
                              }

  end

  test "unlink following to profile", state do
    {:ok, %{data: %{"createProfile" => profile}}} = Absinthe.run(@profiles_create_id_mutation, Schema, variables: %{"profile" => @profile}, context: state[:context])
    profile_id = profile["id"] |> String.to_integer()
    following_ids = [Entity.get_following(state[:context].current_user, "Kyle Simpson").id]
    Absinthe.run(@profiles_link_following_mutation, Schema, variables: %{"id" => profile_id, "following_ids" => following_ids}, context: state[:context])

    {:ok, %{data: %{"unlinkFollowingToProfile" => unlinked_profile}}} = Absinthe.run(@profiles_unlink_following_mutation, Schema, variables: %{"id" => profile_id, "following_ids" => following_ids}, context: state[:context])

    assert unlinked_profile == %{
                                "name" => "Kyle Simpson",
                                "avatarUrl" => "https://profilo.app",
                                "followings" => []
                              }

  end

end
