defmodule Profilo.Repo.Migrations.CreateProfileTable do
  use Ecto.Migration

  def change do
    create table(:profile) do
      add :name, :string
      add :avatar_url, :string

      timestamps()
    end
  end
end
