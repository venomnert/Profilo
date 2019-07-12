defmodule Profilo.Entity do
  alias Profilo.Entity.Lib.{Following, Profile, SocialLink}
  alias Profilo.Accounts.Lib.User
  alias Profilo.Repo

  import Ecto.Query, warn: false

  # --------------- Following API ---------------
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

  def get_following(%User{} = user, id) when is_integer(id) do
    query = from f in Following,
      where: f.user_id == ^user.id,
      where: f.id == ^id,
      select: f

    Repo.one!(query)
  end

  def get_following(%User{} = user, name) when is_binary(name) do
    query = from f in Following,
      where: f.user_id == ^user.id,
      where: f.name == ^name,
      select: f

    Repo.one!(query)
  end

  def add_following_to_profile(%User{} = user, %Profile{} = profile, %Following{} = following) do
    loaded_profile = get_profile(user, profile.id)
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
    loaded_profile = get_profile(user, profile.id)
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
    get_following(user, following.id)
    |> Repo.delete!()
  end

  def create_following(%User{} = user, %SocialLink{} = social_link, attrs \\ %{}) do
    Following.new_following_changeset(user, social_link, attrs)
    |> Repo.insert()
  end

  # --------------- Profile API ---------------
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

  def get_profile(%User{} = user, id) do
    query = from p in Profile,
      where: p.user_id == ^user.id,
      where: p.id == ^id,
      select: p

    Repo.one!(query)
  end

  def update_profile(%User{} = user, %Profile{} = profile, attrs) do
    get_profile(user, profile.id)
    |> Profile.changeset(attrs)
    |> Repo.update!()
  end

  @spec delete_profile(Profilo.Accounts.Lib.User.t(), Profilo.Entity.Lib.Profile.t()) :: any
  def delete_profile(%User{} = user, %Profile{} = profile) do
    get_profile(user, profile.id)
    |> Repo.delete!()
  end

  # --------------- SocialLink API ---------------
  def list_social_links() do
    query = from s in SocialLink,
            select: s

    Repo.all(query)
  end

  def create_social_link(attrs \\ %{}) do
    %SocialLink{}
    |> SocialLink.changeset(attrs)
    |> Repo.insert()
  end

  def get_social_link(id) when is_integer(id) do
    query = from s in SocialLink,
      where: s.id == ^id,
      select: s

    Repo.one!(query)
  end

  def get_social_link(name) when is_binary(name) do
    query = from s in SocialLink,
      where: s.name == ^name,
      select: s

    Repo.one!(query)
  end

  def update_social_link(%SocialLink{} = social_link, attrs) do
    get_social_link(social_link.id)
    |> SocialLink.changeset(attrs)
    |> Repo.update!()
  end

  def delete_social_link(%SocialLink{} = social_link) do
    get_social_link(social_link.id)
    |> Repo.delete!()
  end

end
