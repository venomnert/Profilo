defmodule Profilo.Repo.Migrations.UpdateEmailField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string
    end

    create unique_index(:users, [:email])
  end
end
