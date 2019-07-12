defmodule ProfiloWeb.Schema do
  use Absinthe.Schema

  alias Profilo.Entity
  alias Profilo.Entity.Lib.Following
  alias Profilo.Repo

  query do
    field :followings, list_of(:following) do
      resolve fn(_, _, _) ->
        {:ok, Repo.all(Following)}
      end
    end
  end

  object :following do
    field :id, :id
    field :name, :string
    field :avatar_url, :string
  end

end
