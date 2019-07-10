defmodule Profilo.Entity.Lib.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Profilo.Entity.Lib.{Following, Profile}
  alias Profilo.Accounts.Lib.User

  schema "profile" do
    field :name, :string
    field :avatar_url, :string

    has_many :following, Following,
      on_delete: :delete_all,
      foreign_key: :profile_id,
      on_replace: :nilify

    belongs_to :user, User

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> Ecto.build_assoc(:profile)
    |> changeset(attrs)
  end

  def changeset(%Profile{} = profile, attrs) do
    profile
    |> cast(attrs, [:name, :avatar_url])
    |> validate_required([:name], message: "Name is required.", trim: true)
    |> validate_required([:avatar_url], message: "Avatar image url is required", trim: true)
  end
end
