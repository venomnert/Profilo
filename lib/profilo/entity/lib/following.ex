defmodule Profilo.Entity.Lib.Following do
  use Ecto.Schema
  import Ecto.Changeset

  alias Profilo.Accounts.Lib.User
  alias Profilo.Entity.Lib.{Profile, SocialLink}

  schema "following" do
    field :name, :string
    field :avatar_url, :string
    belongs_to :profile, Profile
    belongs_to :user, User
    belongs_to :social_link, SocialLink

    timestamps()
  end

  def changeset(following, attrs) do
    following
    |> cast(attrs, [:name, :avatar_url])
    |> validate_required([:name], message: "Name is required.", trim: true)
    |> validate_required([:avatar_url], message: "Avatar image url is required", trim: true)
  end

  def new_following_changeset(%User{} = curr_user, %SocialLink{} = social_link, attrs) do
    following_with_user = curr_user
                          |> Ecto.build_assoc(:following)

    following_with_social_link = social_link
                                  |> Ecto.build_assoc(:following)

    %{ following_with_user | social_link_id: following_with_social_link.social_link_id}
    |> changeset(attrs)

  end
end




