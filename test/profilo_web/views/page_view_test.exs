defmodule ProfiloWeb.PageViewTest do
  use ProfiloWeb.ConnCase, async: true

  # alias ProfiloWeb.PageController
  # alias Profilo.Accounts

  # @valid_attrs %{
  #   email: "test@gmail.com",
  #   password: "1234567890",
  #   current_password: "1234567890",
  #   confirm_password: "1234567890",
  #   address: "some address",
  #   company: "some company",
  #   first_name: "some first_name",
  #   last_name: "some last_name",
  #   phone_number: "some phone_number",
  #   website: "some website"
  # }

  # defp setup_user(conn) do
  #   {:ok, user} = Accounts.create_user(@valid_attrs)
  #   Map.put(conn, :assigns, %{current_user: user})
  # end

  # test "get api" do
  #   conn = conn
  #           |> setup_user()
  #           |> PageController.get_user(%{"provider" => "twitter"})
  #           |> put_view(:page_view)
  #   assert json_response(conn, 200)["id"] === nil
  # end
end
