defmodule Profilo.Repo.Migrations.AddAdminUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_admin, :boolean, default: false, null: false
      add :password_hash, :string
    end
  end
end
