defmodule Profilo.Entity.Lib.FeedNode do
  use Ecto.Schema
  import Ecto.Changeset
  alias Profilo.Entity.Lib.{Profile, FeedNode}
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
end
