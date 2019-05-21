defmodule ProfiloWeb.PageView do
  use ProfiloWeb, :view
  alias Jason


  def render("data.json", %{twitter: data}) do
    %{
      data: data
    }
  end
  def render("user.json", %{data: user}) do
    %{
      access_token: user.access_token,
      id: user.id,
      oauth_token: user.oauth_token,
      oauth_token_secret: user.oauth_token_secret,
      provider: user.provider,
      uid: user.uid,
      user_id: user.user_id
    }
  end
end
