defmodule Profilo.Repo.Migrations.CreateFeedNodeTable do
  use Ecto.Migration

  def up do
    create table(:feed_node) do
      add :description, :string
      add :user_id, references("users")
      add :profile_id, references("profile")
      add :social_link_id, references("social_link")

      timestamps()
    end
  end

  def down do
    drop table(:feed_node)
  end
end
