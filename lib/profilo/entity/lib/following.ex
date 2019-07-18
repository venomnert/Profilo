defmodule Profilo.Entity.Lib.Following do
  use Ecto.Schema
  import Ecto.Changeset

  alias Profilo.Accounts.Lib.User
  alias Profilo.Entity.Lib.{Profile, SocialLink, Following}

  schema "following" do
    field :name, :string
    field :avatar_url, :string
    field :screen_name, :string
    belongs_to :profile, Profile
    belongs_to :user, User
    belongs_to :social_link, SocialLink

    timestamps()
  end

  def changeset(following, attrs) do
    following
    |> cast(attrs, [:name, :avatar_url, :screen_name])
    |> validate_required([:name], message: "Name is required.", trim: true)
    |> validate_required([:screen_name], message: "Screen name is required.", trim: true)
    |> validate_required([:avatar_url], message: "Avatar image url is required", trim: true)
    |> unique_constraint(:name, name: :following_user_id_name)
  end

  def new_following_changeset(%User{} = curr_user, %SocialLink{} = social_link, attrs) do
    [curr_user, social_link]
    |> Enum.reduce(%Following{}, fn (has_many, following) ->
        has_many
        |> Ecto.build_assoc(:following, following)
      end)
    |> changeset(attrs)
  end
end




