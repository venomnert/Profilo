defmodule ProfiloWeb.ResolverFollowing do
  alias Profilo.Entity

  def get_following(_, %{id: id}, %{context: %{current_user: current_user}}) do
    case Entity.get_following(current_user, id) do
      result  -> {:ok, result}
      nil     -> {:error, Entity.create_following(current_user, %{})}
    end
  end
  def get_following(_, %{name: name}, %{context: %{current_user: current_user}}) do
    case Entity.get_following(current_user, name) do
      result  -> {:ok, result}
      nil     -> {:error, Entity.create_following(current_user, %{})}
    end
  end
  def get_following(_, %{profile_id: id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, id)
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
  def get_following(_, %{profile_name: name}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, name)
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
  def get_following(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_user_followings(current_user)}
  end

end
