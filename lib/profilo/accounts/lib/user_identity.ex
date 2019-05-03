defmodule Profilo.Accounts.Lib.UserIdentity do
  use Ecto.Schema
  use PowAssent.Ecto.UserIdentities.Schema, user: Profilo.Accounts.Lib.User

  schema "user_identities" do
    pow_assent_user_identity_fields()

    timestamps(updated_at: false)
  end
end
