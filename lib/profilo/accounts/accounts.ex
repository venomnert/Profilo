defmodule Profilo.Accounts do
  import Ecto.Query, warn: false

  alias Profilo.Repo
  alias Profilo.Accounts.Lib.User
  alias Profilo.Accounts.Lib.UserIdentity
  alias Bcrypt

  @spec list_users() :: list(%User{})
  def list_users do
    Repo.all(User)
  end

  @spec get_user!(integer) :: %User{}
  def get_user!(id) do
    User
    |> Repo.get!(id)
  end

  def get_user_identity!(%User{} = user, provider) do
    query = from u in UserIdentity,
      where: u.user_id == ^user.id and u.provider == ^provider,
      select: u

    Repo.one(query)
  end

  @spec create_user(%{
          optional(:__struct__) => none(),
          optional(atom() | binary()) => any()}) ::
        {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(%User{}, %{
          optional(:__struct__) => none(),
          optional(atom() | binary()) => any()}) ::
          {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @spec change_user(%User{}) :: Ecto.Changeset.t()
  def change_user(%User{} = user) do
    user
    |> User.changeset(%{})
  end

  @spec delete_user(%User{}) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def delete_user(%User{} = user) do
    user
    |> Repo.delete()
  end
end
