defmodule Profilo.Accounts do
  import Ecto.Query, warn: false

  alias Profilo.Repo
  alias Profilo.Accounts.Lib.User
  alias Bcrypt

  def list_users, do: Repo.all(User)

  def get_user!(id), do: Repo.get!(User, id)

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

  def change_user(%User{} = user), do: User.changeset(user, %{})

  def delete_user(%User{} = user), do: Repo.delete(user)

end
