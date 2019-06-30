defmodule Profilo.Repo.Migrations.AddGithubUsernameToUserIdentityTable do
  use Ecto.Migration

  def change do
    alter table(:user_identities) do
      add :login, :string
    end
  end
end
