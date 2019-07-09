defmodule Profilo.Entity.Lib.SocialLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias Profilo.Entity.Lib.Following
  alias Profilo.Entity.Lib.SocialLink

  schema "social_link" do
    field :name, :string

    has_many :following, Following,
      on_delete: :delete_all,
      foreign_key: :social_link_id

    timestamps()
  end

  def changeset(%SocialLink{} = social_link, attrs) do
    social_link
    |> cast(attrs, [:name])
    |> validate_required([:name], message: "Name is required.", trim: true)
  end
end
