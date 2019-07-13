defmodule ProfiloWeb.Resolvers do
  alias Profilo.Entity
  def get_profile(_, %{id: id}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_profile(current_user, id)}
  end
  def get_profile(_, %{name: name}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_profile(current_user, name)}
  end
  def get_following(_, %{id: id}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_following(current_user, id)}
  end
  def get_following(_, %{name: name}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_following(current_user, name)}
  end
end
