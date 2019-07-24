defmodule Profilo.Accounts.Lib.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema

  import Ecto.Changeset

  alias Bcrypt

  schema "users" do
    has_many :user_identities,
      Profilo.Accounts.Lib.UserIdentity,
      on_delete: :delete_all,
      foreign_key: :user_id

    has_many :following, Profilo.Entity.Lib.Following,
      on_delete: :delete_all,
      foreign_key: :user_id

    has_many :profile, Profilo.Entity.Lib.Profile,
      on_delete: :delete_all,
      foreign_key: :user_id

    has_many :feed_node, Profilo.Entity.Lib.FeedNode,
      on_delete: :delete_all,
      foreign_key: :user_id

    field :first_name, :string
    field :last_name, :string
    field :address, :string
    field :company, :string
    field :phone_number, :string
    field :website, :string
    field :is_admin, :boolean, default: false

    pow_user_fields()

    timestamps()
  end

  @required_fields ~w(first_name last_name)a
  @optional_fields ~w(address company phone_number website)a

  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
