defmodule Profilo.Repo.Migrations.AddNameContraintProfile do
  use Ecto.Migration

  def change do
    create unique_index(:profile, [:name, :user_id], name: :profile_user_id_name)
  end
end
