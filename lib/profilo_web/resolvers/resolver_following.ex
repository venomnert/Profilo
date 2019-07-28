defmodule ProfiloWeb.ResolverFollowing do
  alias Profilo.Entity
  alias Profilo.Entity.Lib.Following

  def get_following(_, %{id: id}, %{context: %{current_user: current_user}}) do
    case Entity.get_following(current_user, id) do
      nil     -> {:error, Entity.create_following(current_user, %{})}
      result  -> {:ok, result}
    end
  end
  def get_following(_, %{name: name}, %{context: %{current_user: current_user}}) do
    case Entity.get_following(current_user, name) do
      nil     -> {:error, Entity.create_following(current_user, %{})}
      result  -> {:ok, result}
    end
  end

  def list_followings(_, %{profile_id: id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, id)
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
  def list_followings(_, %{profile_name: name}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, name)
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
  def list_followings(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_user_followings(current_user)}
  end
  def list_followings(_, _, arg3) do
    # IO.inspect(arg3, label: "ERROR")
    {:ok, %{message: "hello"}}
  end

  def get_profile(%Following{} = following, _, %{context: %{current_user: current_user}}) do
    case Entity.get_profile(current_user, following.profile_id) do
      nil     -> {:error, Entity.create_profile(current_user, %{})}
      result  -> {:ok, result}
    end
  end
  def get_social_link(%Following{} = following, _, %{context: %{current_user: _current_user}}) do
    case Entity.get_social_link(following.social_link_id) do
      nil     -> {:error, %{message: "no following"}}
      result  -> {:ok, result}
    end
  end
end
