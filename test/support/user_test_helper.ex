defmodule Profilo.Test.UserTestHelper do
  alias Profilo.Accounts

  def user_fixture(valid_attr, attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(valid_attr)
      |> Accounts.create_user()

    user
  end
end
