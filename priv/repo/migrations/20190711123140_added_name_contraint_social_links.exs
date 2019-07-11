defmodule Profilo.Repo.Migrations.AddedNameContraintSocialLinks do
  use Ecto.Migration

  def change do
    create unique_index(:social_link, [:name])
  end
end
