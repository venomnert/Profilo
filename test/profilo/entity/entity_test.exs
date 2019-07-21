defmodule Profilo.EntityTest do
  use Profilo.DataCase

  alias Profilo.Entity
  alias Profilo.Entity.Lib.{Following, Profile, SocialLink, FeedNode}

  alias Profilo.Test.UserTestHelper

  @valid_github_following %{
    "avatarUrl" => "https://avatars1.githubusercontent.com/u/150330?v=4",
    "name" => "Kyle Simpson",
    "login" => "getify"
  }

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
    name: "no profile",
    avatar_url: "https://profilo.app"
  }
  @update_profile_attrs %{
    name: "Wes Bos",
    avatar_url: "https://avatars2.githubusercontent.com/u/577441?v=4"
  }
  @invalid_profile_attrs %{
    name: nil,
    avatar_url: nil
  }

  @valid_following_attrs %{
    name: "Wes Bos",
    avatar_url: "https://avatars2.githubusercontent.com/u/577441?v=4",
    screen_name: "wesbos"
  }
  @invalid_following_attrs %{
    id: 1,
    name: nil,
    screen_name: nil,
    avatar_url: nil,
    profile_id: nil,
    user_id: nil
  }

  @valid_social_link_attrs %{
    name: "github",
  }
  @update_social_link_attrs %{
    name: "twitter",
  }
  @invalid_social_link_attrs %{
    name: nil
  }

  @valid_feed_node_attrs %{
    description: "This is a post"
  }
  @invalid_feed_node_attrs %{
    description: nil
  }

  setup do
    user = UserTestHelper.user_fixture(@valid__user_attrs)
    {:ok, user: user}
  end

  describe "following" do

    test "create_following/3 with valid data creates a following with nil profile", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      assert following.name == @valid_following_attrs.name
      assert following.avatar_url == @valid_following_attrs.avatar_url
      assert following.screen_name == @valid_following_attrs.screen_name
    end

    test "create_github_following/2 with valid data creates a github following with nil profile", state do
      Entity.create_social_link(@valid_social_link_attrs)

      assert {:ok, %Following{} = following} = Entity.create_github_following(state[:user], @valid_github_following)
      assert following.name == @valid_github_following["name"]
      assert following.avatar_url == @valid_github_following["avatarUrl"]
      assert following.screen_name == @valid_github_following["login"]
    end

    test "test duplicate following creation", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      Entity.add_following_to_profile(state[:user], profile, following)

      {:error, %Ecto.Changeset{}} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      assert length(Entity.list_user_followings(state[:user])) == 1
    end

    test "create_following/3 with invalid data returns error changeset", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert {:error, %Ecto.Changeset{}} = Entity.create_following(state[:user], social_link, @invalid_following_attrs)
    end

    test "list_user_followings/1 returns all followings by user", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      Entity.create_following(state[:user], social_link, @valid_following_attrs)

      [first | _ ] = Entity.list_user_followings(state[:user])
      assert first.name == @valid_following_attrs.name
      assert first.avatar_url == @valid_following_attrs.avatar_url
    end

    test "list_profile_followings/2 returns all followings by profile", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      profile = Entity.add_following_to_profile(state[:user], profile, following)

      [first | _ ] = Entity.list_profile_followings(state[:user], profile)
      assert first.name == @valid_following_attrs.name
      assert first.avatar_url == @valid_following_attrs.avatar_url
    end

    test "get_following_by_social_link/2 returns all followings associated to a profile by specified social link", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)
      Entity.add_following_to_profile(state[:user], profile, following)

      github_following = Entity.get_following_by_social_link(state[:user], profile, "github")
      assert github_following.name == @valid_following_attrs.name
      assert github_following.avatar_url == @valid_following_attrs.avatar_url
      assert github_following.social_link_id == social_link.id
    end

    test "get_following!/2 returns the following with given id", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      added_following = Entity.get_following(state[:user], following.id)

      assert added_following.name == @valid_following_attrs.name
      assert added_following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "get_following!/2 returns the following with given name", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      added_following = Entity.get_following(state[:user], following.name)

      assert added_following.name == @valid_following_attrs.name
      assert added_following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "delete_following/1 deletes the following by id", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      assert following = Entity.delete_following(state[:user], following.id)
    end

    test "delete_following/1 deletes the following by name", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)

      assert following = Entity.delete_following(state[:user], following.name)
    end

  end

  describe "profile" do

    test "list_user_profiles/1 returns all profiles by user", state do
      Entity.create_profile(state[:user], @valid_profile_attrs)

      [first | _ ] = Entity.list_user_profiles(state[:user])
      assert first.name == @valid_profile_attrs.name
      assert first.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "get_profiles_by_social_link/2 returns all profiles by specified social link", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      Entity.add_following_to_profile(state[:user], profile, following)

      github_profile = Entity.get_profiles_by_social_link(state[:user], "github") |> List.first() |> Repo.preload(:following)
      github_following = github_profile.following |> List.first()

      assert github_profile.name == @valid_profile_attrs.name
      assert github_profile.avatar_url == @valid_profile_attrs.avatar_url

      assert github_following.name == @valid_following_attrs.name
      assert github_following.avatar_url == @valid_following_attrs.avatar_url
      assert github_following.screen_name == @valid_following_attrs.screen_name
      assert github_following.social_link_id == social_link.id
    end

    test "create_profile/2 with valid data", state do
      assert {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert profile.name == @valid_profile_attrs.name
      assert profile.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "create_profile/2 with invalid data", state do
      assert {:error, %Ecto.Changeset{}} = Entity.create_profile(state[:user], @invalid_profile_attrs)
    end

    test "get_profile/2 returns the profile with given id", state do
      {:ok, %Profile{} = new_profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert new_profile = Entity.get_profile(state[:user], new_profile.id)
      assert new_profile.name == @valid_profile_attrs.name
      assert new_profile.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "get_profile/2 returns the profile with given name", state do
      {:ok, %Profile{} = new_profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert new_profile = Entity.get_profile(state[:user], new_profile.name)
      assert new_profile.name == @valid_profile_attrs.name
      assert new_profile.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "update_profile/3 with valid data updates the profile", state do
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      {:ok, update_profile} = Entity.update_profile(state[:user], profile, @update_profile_attrs)
      assert update_profile.name == @update_profile_attrs.name
      assert update_profile.avatar_url == @update_profile_attrs.avatar_url
    end

    test "update_profile/3 with invalid data returns error changeset", state do
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert {:error, %Ecto.Changeset{} = error} = Entity.update_profile(state[:user], profile, @invalid_profile_attrs)
    end

    test "add_following_to_profile/3 with a new following", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      first_following = Entity.add_following_to_profile(state[:user], profile, following)
                        |> Repo.preload(:following)
                        |> Map.get(:following)
                        |> List.first()

      assert first_following.name == @valid_following_attrs.name
      assert first_following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "add_following_to_profile/3 with a duplicate following", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      new_profile = Entity.add_following_to_profile(state[:user], profile, following)
      second_profile = Entity.add_following_to_profile(state[:user], new_profile, following)
      assert new_profile = second_profile
    end

    test "removing_following_from_profile/3", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      new_profile = Entity.add_following_to_profile(state[:user], profile, following)

      following_list = new_profile
                      |> Repo.preload(:following)
                      |> Map.get(:following)
                      |> MapSet.new()

      updated_following_list = Entity.removing_following_from_profile(state[:user], new_profile, following)
                                |> Repo.preload(:following)
                                |> Map.get(:following)
                                |> MapSet.new()

      refute MapSet.equal?(following_list, updated_following_list)
    end

    test "delete_profile/1 deletes the profile by id", state do
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert profile = Entity.delete_profile(state[:user], profile.id)
    end

    test "delete_profile/1 deletes the profile by name", state do
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert profile = Entity.delete_profile(state[:user], profile.name)
    end
  end

  describe "social_link" do
    test "list_social_links/0 returns all social links" do
      Entity.create_social_link(@valid_social_link_attrs)

      [first | _ ] = Entity.list_social_links()
      assert first.name == @valid_social_link_attrs.name
    end

    test "create_social_link/1 with valid data" do
      assert {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert social_link.name == @valid_social_link_attrs.name
    end

    test "create_social_link/1 with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Entity.create_social_link(@invalid_social_link_attrs)
    end

    test "get_social_link/1 returns the social_link with given id" do
      {:ok, %SocialLink{} = new_social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert new_social_link = Entity.get_social_link(new_social_link.id)
      assert new_social_link.name == @valid_social_link_attrs.name
    end

    test "get_social_link/1 returns the social_link with given name" do
      Entity.create_social_link(@valid_social_link_attrs)

      assert new_social_link = Entity.get_social_link("github")
      assert new_social_link.name == @valid_social_link_attrs.name
    end

    test "update_social_link/2 with valid data updates the social_link" do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      update_social_link = Entity.update_social_link(social_link, @update_social_link_attrs)
      assert update_social_link.name == @update_social_link_attrs.name
    end

    test "update_social_link/2 with invalid data returns error changeset" do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert_raise Ecto.InvalidChangesetError, fn ->
        Entity.update_social_link(social_link, @invalid_social_link_attrs)
      end
    end

    test "delete_social_link/1 deletes the social_link" do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)

      assert social_link = Entity.delete_social_link(social_link)
    end
  end

  describe "feed_node" do

    test "create_feed_node/4 with valid data creates a feed_node ", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert {:ok, %FeedNode{} = feed_node} = Entity.create_feed_node(state[:user], profile, social_link, @valid_feed_node_attrs)

      assert feed_node.description == @valid_feed_node_attrs.description
      assert feed_node.user_id == state[:user].id
      assert feed_node.profile_id == profile.id
    end

    test "create_github_feed_node/3 with valid data creates a feed_node with github", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert {:ok, %FeedNode{} = feed_node} = Entity.create_github_feed_node(state[:user], profile, @valid_feed_node_attrs)

      assert feed_node.description == @valid_feed_node_attrs.description
      assert feed_node.user_id == state[:user].id
      assert feed_node.profile_id == profile.id

      feed_node_social_link = feed_node |> Repo.preload(:social_link) |> get_in([Access.key(:social_link), Access.key(:name)])
      assert feed_node_social_link == social_link.name

    end

    test "create_feed_node/4 with invalid data returns error changeset", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      assert {:error, %Ecto.Changeset{}} = Entity.create_feed_node(state[:user], profile, social_link, @invalid_feed_node_attrs)
    end

    test "list_profile_feed_node/2 returns all feed_node by profile", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      Entity.create_feed_node(state[:user], profile, social_link, @valid_feed_node_attrs)

      [first | _ ] = Entity.list_profile_feed_node(state[:user], profile)
      assert first.description == @valid_feed_node_attrs.description
    end

    test "list_social_link_feed_node/2 returns all feed_node by profile", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      Entity.create_github_feed_node(state[:user], profile, @valid_feed_node_attrs)

      [first | _ ] = Entity.list_social_link_feed_node(state[:user], social_link)
      assert first.description == @valid_feed_node_attrs.description
    end

    test "get_feed_node!/2 returns the following with given id", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      {:ok, %FeedNode{} = feed_node} =  Entity.create_feed_node(state[:user], profile, social_link, @valid_feed_node_attrs)


      added_feed_node = Entity.get_feed_node(state[:user], feed_node.id)

      assert added_feed_node.description == @valid_feed_node_attrs.description
    end

    test "delete_feed_node/1 deletes the following", state do
      {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

      {:ok, %FeedNode{} = feed_node} = Entity.create_feed_node(state[:user], profile, social_link, @valid_feed_node_attrs)

      assert feed_node = Entity.delete_feed_node(state[:user], feed_node.id)
    end
  end
end
