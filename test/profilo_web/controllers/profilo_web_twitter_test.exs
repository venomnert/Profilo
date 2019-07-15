defmodule ProfiloWeb.Twitter do
  use ProfiloWeb.ConnCase, async: true

  alias Profilo.Repo
  alias Profilo.Accounts.Lib.User
  alias Profilo.Accounts.Lib.UserIdentity
  alias ProfiloWeb.Router.Helpers

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
  @empty_user_identity %{
    "provider" => "nothing",
    "uid" => "1",
    "token" => %{
      access_token: nil,
      oauth_token: nil,
      oauth_token_secret: nil,
    }
  }
  @user_identity %{
    "provider" => "twitter",
    "uid" => "2",
    "token" => %{
      access_token: nil,
      oauth_token: "4215379283-D0Xr52IQjmOqELLY5BEx8R9Sjx5e6Kb3Xkznnsn",
      oauth_token_secret: "DX0NPbVA9De8b8jieAE1M2DEwxMBCJzWyPnW37xuiVrAg",
    }
  }
   defp setup_provider(conn, attr) do
    # Create user
    user =
      %User{}
      |> User.changeset(@valid_attrs)
      |> Repo.insert!()

    # Create user identity
    user
    |> Ecto.build_assoc(:user_identities)
    |> UserIdentity.changeset(attr)
    |> Repo.insert!()

    Map.put(conn, :assigns, %{current_user: user})
  end

  @tag failed: true
  # test "user is not signed into twitter" do
  #   conn =
  #     build_conn()
  #     |> setup_provider(@empty_user_identity)

  #   conn = get(conn, Helpers.page_path(conn, :is_auth, "twitter"))

  #   assert json_response(conn, 200)["access_token"] == nil
  #   assert json_response(conn, 200)["id"] == nil
  #   assert json_response(conn, 200)["oauth_token"] == nil
  #   assert json_response(conn, 200)["oauth_token_secret"] == nil
  #   assert json_response(conn, 200)["provider"] == nil
  #   assert json_response(conn, 200)["uid"] == nil
  #   assert json_response(conn, 200)["user_id"] == nil
  # end

  # test "user is signed into twitter" do
  #   conn =
  #     build_conn()
  #     |> setup_provider(@user_identity)

  #   conn = get(conn, Helpers.page_path(conn, :is_auth, "twitter"))

  #   assert json_response(conn, 200)["access_token"] == nil
  #   assert json_response(conn, 200)["oauth_token"] == "4215379283-D0Xr52IQjmOqELLY5BEx8R9Sjx5e6Kb3Xkznnsn"
  #   assert json_response(conn, 200)["oauth_token_secret"] == "DX0NPbVA9De8b8jieAE1M2DEwxMBCJzWyPnW37xuiVrAg"
  #   assert json_response(conn, 200)["provider"] == "twitter"
  #   refute json_response(conn, 200)["id"] == nil
  #   refute json_response(conn, 200)["uid"] == nil
  #   refute json_response(conn, 200)["user_id"] == nil
  # end

  # test "twitter failed request with empty user" do
  #   conn =
  #     build_conn()
  #     |> setup_provider(@empty_user_identity)

  #   conn = get(conn, Helpers.page_path(conn, :get_user, "twitter"))
  #   assert json_response(conn, 404)["status"] == "error"
  # end

  # @tag failed: true
  # test "twitter failed request" do
  #   conn =
  #     build_conn()
  #     |> setup_provider(@user_identity)

  #   conn = get(conn, Helpers.page_path(conn, :get_user, "twitter"))
  #   assert json_response(conn, 404)["status"] == "error"
  # end

  # test "twitter success request" do
  #   conn =
  #     build_conn()
  #     |> setup_provider(@user_identity)

  #   conn = get(conn, Helpers.page_path(conn, :get_user, "twitter"))
  #   refute json_response(conn, 200)["data"] == nil
  # end
end
