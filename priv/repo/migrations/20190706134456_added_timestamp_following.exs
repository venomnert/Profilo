defmodule Profilo.Repo.Migrations.AddedTimestampFollowing do
  use Ecto.Migration

  def change do
    alter table(:following) do
      timestamps()
    end
  end
end
