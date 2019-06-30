defmodule Profilo.Repo.Migrations.UpdateNameFieldUserIdentity do
  use Ecto.Migration

  def change do
    rename table(:user_identities), :name, to: :screen_name
  end
end
