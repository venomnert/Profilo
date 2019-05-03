defmodule Profilo.Accounts do
  import Ecto.Query, warn: false

  alias Profilo.Repo
  alias Profilo.Accounts.Lib.User
  alias Bcrypt

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def change_user(%User{} = user) do
    user
    |> User.changeset(%{})
  end

  def delete_user(%User{} = user) do
    user
    |> Repo.delete()
  end
end
