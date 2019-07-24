defmodule Profilo.Repo.Migrations.CreateSocialLinkTable do
  use Ecto.Migration

  def up do
    create table(:social_link) do
      add :name, :string

      timestamps()
    end

    create unique_index(:social_link, [:name])
  end

  def down do
    drop table(:social_link)
  end
end
