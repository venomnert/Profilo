defmodule Profilo.Repo.Migrations.UserTokenUserIdenitiesTable do
  use Ecto.Migration

  def change do
    alter table(:user_identities) do
      add :access_token, :string
    end
  end
end
