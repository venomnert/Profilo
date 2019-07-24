defmodule ProfiloWeb.ResolverProfile do
  alias Profilo.Entity
  alias Profilo.Entity.Lib.Profile

  def get_profile(_, %{id: id}, %{context: %{current_user: current_user}}) do
    case Entity.get_profile(current_user, id) do
      nil     -> {:error, Entity.create_profile(current_user, %{})}
      result  -> {:ok, result}
    end
  end
  def get_profile(_, %{name: name}, %{context: %{current_user: current_user}}) do
    case Entity.get_profile(current_user, name) do
      nil     -> {:error, Entity.create_profile(current_user, %{})}
      result  -> {:ok, result}
    end
  end
  def get_profile(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_user_profiles(current_user)}
  end
  def list_profile_followings(%Profile{} = profile, _, %{context: %{current_user: current_user}}) do
    {:ok, Entity.list_profile_followings(current_user, profile)}
  end
  def create_profile(_, %{input: attrs}, %{context: %{current_user: current_user}}) do
    case Entity.create_profile(current_user, attrs) do
      {:ok, %Profile{} = profile} -> {:ok, profile}
      {:error, %Ecto.Changeset{} = error} -> {:error, get_error_message(error)}
    end
  end
  def update_profile(_, %{input: attrs, id: profile_id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, profile_id)

    Entity.update_profile(current_user, profile, attrs)
    |> case do
      {:ok, profile} -> {:ok, profile}
      {:error, %Ecto.Changeset{} = error} -> {:error, get_error_message(error)}
    end

  end
  def link_following_to_profile(_, %{followings: followings, id: profile_id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, profile_id)

    linked_profile = followings
                      |> Enum.reduce(profile, fn (following_id, profile) ->
                        following = Entity.get_following(current_user, following_id)
                        Entity.add_following_to_profile(current_user, profile, following)
                      end)

    {:ok, linked_profile}
  end
  def unlink_following_to_profile(_, %{followings: followings, id: profile_id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, profile_id)

    unlinked_profile = followings
                      |> Enum.reduce(profile, fn (following_id, profile) ->
                        following = Entity.get_following(current_user, following_id)
                        Entity.removing_following_from_profile(current_user, profile, following)
                      end)

    {:ok, unlinked_profile}
  end

  defp get_error_message(error) do
    error.errors
    |> Keyword.get(:name)
    |> elem(0)
  end
end
