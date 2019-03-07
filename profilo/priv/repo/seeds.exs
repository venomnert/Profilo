# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Profilo.Repo.insert!(%Profilo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Profilo.Accounts

accounts_data = [
  %{
    address: "1600 Sandhurst Circle",
    company: "McDonalds",
    first_name: "Ian",
    last_name: "Kelly",
    phone_number: "416-551-2626",
    website: "tesla.com"
  },
  %{
    address: "38 Ox Drive",
    company: "ai.io",
    first_name: "Jon",
    last_name: "Doe",
    phone_number: "416-453-4134",
    website: "test.app"
  },
  %{
    address: "30 Stonechruch Cr",
    company: "Home Depot",
    first_name: "Kelly",
    last_name: "Smith",
    phone_number: "416-432-7654",
    website: "kellys.com"
  }
]

Enum.each(accounts_data, fn (data) -> Accounts.create_user(data) end)
