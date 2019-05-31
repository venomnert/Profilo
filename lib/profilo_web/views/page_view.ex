defmodule ProfiloWeb.PageView do
  use ProfiloWeb, :view
  alias Jason

  def render("data.json", %{data: data}) do
    {:ok, new_data} = data
                      |> convert_list_to_map_of_id()
                      |> Jason.encode()
    %{
      data: new_data
    }
  end
  def render("error.json", %{data: message}) do
    %{
      status: "error",
      title: message
    }
  end
  def render("user.json", %{user: data}) do
    %{
      access_token: data.access_token,
      id: data.id,
      oauth_token: data.oauth_token,
      oauth_token_secret: data.oauth_token_secret,
      provider: data.provider,
      uid: data.uid,
      user_id: data.user_id
    }
  end

  defp convert_list_to_map_of_id(data) do
    data
    |> Enum.reduce(%{}, fn x, acc -> Map.put_new(acc, x.id, x) end)
  end
end
