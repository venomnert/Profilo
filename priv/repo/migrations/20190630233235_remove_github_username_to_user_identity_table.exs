defmodule Profilo.Repo.Migrations.RemoveGithubUsernameToUserIdentityTable do
  use Ecto.Migration

  def change do
    alter table(:user_identities) do
      remove :login
    end
  end
end
