defmodule Profilo.Repo.Migrations.CreateSocialLinkTable do
  use Ecto.Migration

  def change do
    create table(:social_link) do
      add :name, :string

      timestamps()
    end
  end
end
