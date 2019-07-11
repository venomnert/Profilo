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
alias Profilo.Entity

social_links = [
  %{
    name: "github"
  },
  %{
    name: "twitter"
  },
]

social_links
|> Enum.each(&(Entity.create_social_link(&1)))
