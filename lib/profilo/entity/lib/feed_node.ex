defmodule Profilo.Entity.Lib.FeedNode do
  use Ecto.Schema
  import Ecto.Changeset
  alias Profilo.Entity.Lib.{Profile, FeedNode, SocialLink}
  alias Profilo.Accounts.Lib.User

  schema "feed_node" do
    field :description, :string
    belongs_to :user, User
    belongs_to :profile, Profile
    belongs_to :social_link, SocialLink

    timestamps()
  end

  def changeset(%FeedNode{} = feed_node, attrs) do
    feed_node
    |> cast(attrs, [:description])
    |> validate_required([:description], message: "Description is required.", trim: true)
    |> unique_constraint(:description)
  end

  def create_new_feed_changeset(%User{} = curr_user, %Profile{} = profile, %SocialLink{} = social_link, attrs \\ %{}) do
    [curr_user, profile, social_link]
    |> Enum.reduce(%FeedNode{}, fn (has_many, feed_node) ->
        has_many
        |> Ecto.build_assoc(:feed_node, feed_node)
      end)
    |> changeset(attrs)

  end
end
