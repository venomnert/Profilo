defmodule Profilo.Repo.Migrations.AddEmailUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string, unique: true
    end
  end
end
