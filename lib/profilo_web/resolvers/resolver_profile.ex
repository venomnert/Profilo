defmodule ProfiloWeb.ResolverProfile do
  alias Profilo.Entity
  alias Profilo.Entity.Lib.Profile

  def get_profile(_, %{id: id}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_profile(current_user, id)}
  end
  def get_profile(_, %{name: name}, %{context: %{current_user: current_user}}) do
    {:ok, Entity.get_profile(current_user, name)}
  end
  def get_profile(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_user_profiles(current_user)}
  end
  def list_profile_followings(%Profile{} = profile, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
end
