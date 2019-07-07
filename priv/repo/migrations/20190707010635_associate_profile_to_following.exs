defmodule Profilo.Repo.Migrations.AssociateProfileToFollowing do
  use Ecto.Migration

  def change do
    alter table(:following) do
      add :profile_id, references("profile")
    end
  end
end
