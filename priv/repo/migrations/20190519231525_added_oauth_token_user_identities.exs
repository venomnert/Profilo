defmodule Profilo.Repo.Migrations.AddedOauthTokenUserIdentities do
  use Ecto.Migration

  def up do
    alter table(:user_identities) do
      add :oauth_token, :string
      add :oauth_token_secret, :string
    end
  end
end
