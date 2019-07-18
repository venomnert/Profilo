defmodule Profilo.Entity.Lib.FeedNode do
  use Ecto.Schema
  import Ecto.Changeset
  alias Profilo.Entity.Lib.{Profile, FeedNode, SocialLink}
  alias Profilo.Accounts.Lib.User

  schema "feed_node" do
    field :description, :string
    belongs_to :user, User
    belongs_to :profile, Profile

    timestamps()
  end

  def changeset(%FeedNode{} = feed_node, attrs) do
    feed_node
    |> cast(attrs, [:description])
    |> validate_required([:description], message: "Description is required.", trim: true)
  end

  # def create_new_feed_changeset(%User{} = curr_user, %Profile{} = profile, %SocialLink{} = social_link, attrs \\ %{}) do
  #   [curr_user, profile, social_link]
  #   |> Enum.each(fn links ->
  #     link
  #     |> Ecto.build_assoc(:following)
  #   end)

  # end
end
