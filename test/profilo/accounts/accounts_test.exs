defmodule Profilo.AccountsTest do
  use Profilo.DataCase

  alias Profilo.Accounts

  describe "users" do
    alias Profilo.Accounts.Lib.User

    @valid_attrs %{
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

    @update_attrs %{
      email: "change@gmail.com",
      current_password: "1234567890",
      address: "some updated address",
      company: "some updated company",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      phone_number: "some updated phone_number",
      website: "some updated website"
    }

    @invalid_attrs %{
      email: "test@gmail.com",
      current_password: "1234567890",
      address: nil,
      company: nil,
      first_name: nil,
      last_name: nil,
      phone_number: nil,
      website: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def update_password(%User{} = user, %{confirm_password: confirm_password, current_password: current_password, password: password}) do
      user
        |> Map.put(:confirm_password, confirm_password)
        |> Map.put(:current_password, current_password)
        |> Map.put(:password, password)
    end

    def update_password(%User{} = user, %{current_password: current_password}) do
      user
        |> Map.put(:current_password, current_password)
    end

    test "list_users/0 returns all users" do
      user = user_fixture() |> update_password(%{current_password: nil, confirm_password: nil, password: nil})

      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture() |> update_password(%{current_password: nil, confirm_password: nil, password: nil})

      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "test@gmail.com"
      assert user.address == "some address"
      assert user.company == "some company"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
      assert user.website == "some website"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture() |> update_password(%{current_password: nil})

      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "change@gmail.com"
      assert user.address == "some updated address"
      assert user.company == "some updated company"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
      assert user.website == "some updated website"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture() |> update_password(%{current_password: nil, confirm_password: nil, password: nil})
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
