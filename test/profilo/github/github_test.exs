defmodule Profilo.GithubTest do
  use Profilo.DataCase

  alias Profilo.Github
  alias Profilo.Entity
  alias Profilo.Test.UserTestHelper

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

  test "get_followers/1 adds followings to the database" do
    user = UserTestHelper.user_fixture(@valid_user_attrs)
    Entity.create_social_link(@valid_social_link_attrs)

    user
    |> Github.get_followers()

    refute length(Entity.list_user_followings(user)) == 0
  end
end
