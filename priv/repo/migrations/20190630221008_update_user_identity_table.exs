defmodule Profilo.Repo.Migrations.UpdateUserIdentityTable do
  use Ecto.Migration

  def change do
    alter table(:user_identities) do
      add :name, :string
    end
  end
end
