defmodule Profilo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :website, :string
      add :company, :string
      add :address, :string

      timestamps()
    end

  end
end
