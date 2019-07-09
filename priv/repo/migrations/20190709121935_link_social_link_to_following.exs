defmodule Profilo.Repo.Migrations.LinkSocialLinkToFollowing do
  use Ecto.Migration

  def change do
    alter table(:following) do
      add :social_link_id, references("social_link")
    end
  end
end
