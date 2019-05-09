defmodule ProfiloWeb.PageView do
  use ProfiloWeb, :view

  def render("data.json", %{twitter: data}) do
    %{
      data: data
    }
  end
end
