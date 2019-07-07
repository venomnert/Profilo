defmodule Profilo.EntityTest do
  use Profilo.DataCase

  alias Profilo.Entity
  alias Profilo.Entity.Lib.Following
  alias Profilo.Entity.Lib.Profile

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
  }
  @invalid_following_attrs %{
    id: 1,
    name: nil,
    avatar_url: nil,
    profile_id: nil,
    user_id: nil
  }

  describe "following" do

    test "create_following/2 with valid data creates a following with nil profile" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)

      assert {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)
      assert following.name == @valid_following_attrs.name
      assert following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "create_following/1 with invalid data returns error changeset" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      assert {:error, %Ecto.Changeset{}} = Entity.create_following(user, @invalid_following_attrs)
    end

    test "list_user_followings/1 returns all followings by user" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      Entity.create_following(user, @valid_following_attrs)

      [first | _ ] = Entity.list_user_followings(user)
      assert first.name == @valid_following_attrs.name
      assert first.avatar_url == @valid_following_attrs.avatar_url
    end

    test "list_profile_followings/2 returns all followings by profile" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      profile = Entity.add_following_to_profile(user, profile, following)

      [first | _ ] = Entity.list_profile_followings(user, profile)
      assert first.name == @valid_following_attrs.name
      assert first.avatar_url == @valid_following_attrs.avatar_url
    end

    test "get_following!/2 returns the following with given id" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)

      added_following = Entity.get_following(user, following)

      assert added_following.name == @valid_following_attrs.name
      assert added_following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "delete_following/1 deletes the following" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)

      assert following = Entity.delete_following(user, following)
    end
  end

  describe "profile" do

    test "create_profile/2 with valid data" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      assert {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      assert profile.name == @valid_profile_attrs.name
      assert profile.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "create_profile/2 with invalid data" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      assert {:error, %Ecto.Changeset{}} = Entity.create_profile(user, @invalid_profile_attrs)
    end

    test "get_profile!/2 returns the profile with given id" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Profile{} = new_profile} = Entity.create_profile(user, @valid_profile_attrs)

      assert new_profile = Entity.get_profile(user, new_profile)
      assert new_profile.name == @valid_profile_attrs.name
      assert new_profile.avatar_url == @valid_profile_attrs.avatar_url
    end

    test "update_profile/3 with valid data updates the profile" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      update_profile = Entity.update_profile(user, profile, @update_profile_attrs)
      assert update_profile.name == @update_profile_attrs.name
      assert update_profile.avatar_url == @update_profile_attrs.avatar_url
    end

    test "update_profile/3 with invalid data returns error changeset" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      assert_raise Ecto.InvalidChangesetError, fn ->
        Entity.update_profile(user, profile, @invalid_profile_attrs)
      end
    end

    test "add_following_to_profile/3 with a new following" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      first_following = Entity.add_following_to_profile(user, profile, following)
                        |> Repo.preload(:following)
                        |> Map.get(:following)
                        |> List.first()

      assert first_following.name == @valid_following_attrs.name
      assert first_following.avatar_url == @valid_following_attrs.avatar_url
    end

    test "add_following_to_profile/3 with a duplicate following" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      new_profile = Entity.add_following_to_profile(user, profile, following)
      second_profile = Entity.add_following_to_profile(user, new_profile, following)
      assert new_profile = second_profile
    end

    test "removing_following_from_profile/3" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Following{} = following} = Entity.create_following(user, @valid_following_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      new_profile = Entity.add_following_to_profile(user, profile, following)

      following_list = new_profile
                      |> Repo.preload(:following)
                      |> Map.get(:following)
                      |> MapSet.new()

      updated_following_list = Entity.removing_following_from_profile(user, new_profile, following)
                                |> Repo.preload(:following)
                                |> Map.get(:following)
                                |> MapSet.new()

      refute MapSet.equal?(following_list, updated_following_list)
    end

    test "delete_profile/1 deletes the profile" do
      user = UserTestHelper.user_fixture(@valid__user_attrs)
      {:ok, %Profile{} = profile} = Entity.create_profile(user, @valid_profile_attrs)

      assert profile = Entity.delete_profile(user, profile)
    end
  end
end
