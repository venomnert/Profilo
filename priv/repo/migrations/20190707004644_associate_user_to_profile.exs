defmodule Profilo.Repo.Migrations.AssociateUserToProfile do
  use Ecto.Migration

  def change do
    alter table(:profile) do
      add :user_id, references("users")
    end
  end
end
