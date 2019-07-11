defmodule Profilo.Repo.Migrations.CreateNameUserContraintFollowing do
  use Ecto.Migration

  def change do
    create unique_index(:following, [:name, :user_id], name: :following_user_id_name)
  end
end
