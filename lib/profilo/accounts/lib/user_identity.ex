defmodule Profilo.Accounts.Lib.UserIdentity do
  use Ecto.Schema
  use PowAssent.Ecto.UserIdentities.Schema, user: Profilo.Accounts.Lib.User

  schema "user_identities" do
    field :access_token, :string
    field :oauth_token, :string
    field :oauth_token_secret, :string
    pow_assent_user_identity_fields()

    timestamps(updated_at: false)
  end

  def changeset(user_identity_or_changeset, %{"token" => token_map} = attrs) do
    user_identity_or_changeset
    |> Ecto.Changeset.cast(token_map, [:access_token, :oauth_token, :oauth_token_secret])
    |> pow_assent_changeset(attrs)
  end
end
