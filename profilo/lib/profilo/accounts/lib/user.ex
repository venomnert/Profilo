defmodule Profilo.Accounts.Lib.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :address, :string
    field :company, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone_number, :website, :company, :address])
    |> validate_required([:first_name, :last_name, :phone_number, :website, :company, :address])
  end
end
