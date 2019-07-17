defmodule Profilo.Repo.Migrations.CreateFollowingTable do
  use Ecto.Migration

  def up do
    create table(:following) do
      add :name, :string
      add :avatar_url, :string
      add :screen_name, :string
      add :user_id, references("users")
      add :profile_id, references("profile")
      add :social_link_id, references("social_link")

      timestamps()
    end

    create unique_index(:following, [:name, :user_id], name: :following_user_id_name)
  end

  def down do
    drop table(:following)
  end
end
