defmodule Profilo.Repo.Migrations.CreateUserIdentities do
  use Ecto.Migration

  def up do
    create table(:user_identities) do
      add :provider, :string, null: false
      add :uid, :string, null: false
      add :user_id, references("users", on_delete: :nothing)
      add :screen_name, :string
      add :access_token, :string
      add :oauth_token, :string
      add :oauth_token_secret, :string

      timestamps(updated_at: false)
    end

    create unique_index(:user_identities, [:uid, :provider])
  end

  def down do
    drop table(:user_identities)
  end
end
