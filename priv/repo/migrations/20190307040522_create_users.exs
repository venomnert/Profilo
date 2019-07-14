defmodule Profilo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :website, :string
      add :company, :string
      add :address, :string
      add :is_admin, :boolean, default: false, null: false
      add :password_hash, :string
      add :email, :string, unique: true

      timestamps()
    end

    create unique_index(:users, [:email])

  end

  def down do
    drop table(:users)
  end
end
