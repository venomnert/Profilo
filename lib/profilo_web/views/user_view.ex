defmodule ProfiloWeb.UserView do
  use ProfiloWeb, :view
  alias ProfiloWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, result: result}) do
    # %{data: render_one(user, UserView, "user.json")}
    {:ok, first_body} = result
    %Neuron.Response{body: second_body} = first_body
    new_result = get_in(second_body, ["data", "viewer", "following", "nodes"])
    %{result: Jason.encode!(new_result)}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      phone_number: user.phone_number,
      website: user.website,
      company: user.company,
      address: user.address}
  end
end
