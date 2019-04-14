defmodule Profilo.Accounts.Lib.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  alias Bcrypt

  schema "users" do
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
  end
end
