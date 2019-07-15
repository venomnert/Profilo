defmodule ProfiloWeb.ResolverSocialLink do
  alias Profilo.Entity

  def get_social_link(_, %{name: name}, _) do
    case Entity.get_social_link(name) do
      result  -> {:ok, result}
      nil     -> {:error, %{}}
    end
  end
  def get_social_link(_, _, _) do
    {:ok, Entity.list_social_links()}
  end
end
