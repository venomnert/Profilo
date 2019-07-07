defmodule Profilo.Entity do
  alias Profilo.Entity.Lib.Following
  alias Profilo.Entity.Lib.Profile
  alias Profilo.Accounts.Lib.User
  alias Profilo.Repo

  import Ecto.Query, warn: false

  def list_user_followings(%User{} = user) do
    query = from f in Following,
            where: f.user_id == ^user.id,
            select: f

    Repo.all(query)
  end

  @spec list_profile_followings(Profilo.Accounts.Lib.User.t(), Profilo.Entity.Lib.Profile.t()) ::
          any
  def list_profile_followings(%User{} = user, %Profile{} = profile) do
    query = from f in Following,
            where: f.user_id == ^user.id,
            where: f.profile_id == ^profile.id,
            select: f

    Repo.all(query)
  end

  def get_following(%User{} = user, %Following{} = following) do
    query = from f in Following,
      where: f.user_id == ^user.id,
      where: f.id == ^following.id,
      select: f

    Repo.one!(query)
  end

  def add_following_to_profile(%User{} = user, %Profile{} = profile, %Following{} = following) do
    loaded_profile = get_profile(user, profile)
    |> Repo.preload(:following)

    loaded_profile
    |> Profile.changeset(%{})
    |> Ecto.Changeset.put_assoc(:following, append_following(following, loaded_profile.following))
    |> Repo.update!()
  end

  defp append_following(following, []), do: [following]
  defp append_following(following, following_list) do
    [following | following_list]
    |> Enum.uniq_by(fn(%Following{} = following) -> following.id end)
  end

  def removing_following_from_profile(%User{} = user, %Profile{} = profile, %Following{} = following) do
    loaded_profile = get_profile(user, profile)
    |> Repo.preload(:following)

    loaded_profile
    |> Profile.changeset(%{})
    |> Ecto.Changeset.put_assoc(:following, remove_following(following, loaded_profile.following))
    |> Repo.update!()
  end

  defp remove_following(following, []), do: [following]
  defp remove_following(following, following_list) do
    following_list
    |> Enum.filter(fn curr_following -> curr_following.id != following.id end)
  end

  def delete_following(%User{} = user, %Following{} = following) do
    get_following(user, following)
    |> Repo.delete!()
  end

  @spec create_following(
          Profilo.Accounts.Lib.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def create_following(%User{} = user, attrs \\ %{}) do
    Following.new_following_changeset(user, attrs)
    |> Repo.insert()
  end

  def list_user_profiles(%User{} = user) do
    query = from p in Profile,
            where: p.user_id == ^user.id,
            select: p

    Repo.all(query)
  end

  @spec create_profile(
          Profilo.Accounts.Lib.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def create_profile(%User{} = user, attrs \\ %{}) do
    Profile.changeset(user, attrs)
    |> Repo.insert()
  end

  def get_profile(%User{} = user, %Profile{} = profile) do
    query = from p in Profile,
      where: p.user_id == ^user.id,
      where: p.id == ^profile.id,
      select: p

    Repo.one!(query)
  end

  def update_profile(%User{} = user, %Profile{} = profile, attrs) do
    get_profile(user, profile)
    |> Profile.changeset(attrs)
    |> Repo.update!()
  end

  @spec delete_profile(Profilo.Accounts.Lib.User.t(), Profilo.Entity.Lib.Profile.t()) :: any
  def delete_profile(%User{} = user, %Profile{} = profile) do
    get_profile(user, profile)
    |> Repo.delete!()
  end
end
