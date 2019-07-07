defmodule Profilo.Repo.Migrations.CreateFollowingTableWithUser do
  use Ecto.Migration

  def change do
    create table(:following) do
      add :name, :string
      add :avatar_url, :string
      add :user_id, references("users")
    end
  end
end
