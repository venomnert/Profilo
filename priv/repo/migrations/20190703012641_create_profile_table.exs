defmodule Profilo.Repo.Migrations.CreateProfileTable do
  use Ecto.Migration

  def up do
    create table(:profile) do
      add :name, :string
      add :avatar_url, :string
      add :user_id, references("users")

      timestamps()
    end

    create unique_index(:profile, [:name, :user_id], name: :profile_user_id_name)
  end

  def down do
    drop table(:profile)
  end
end
