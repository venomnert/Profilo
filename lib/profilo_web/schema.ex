defmodule ProfiloWeb.Schema do
  use Absinthe.Schema

  alias Profilo.Entity
  alias Profilo.Entity.Lib.{Following, Profile}
  alias Profilo.Repo

  query do
    field :followings, list_of(:following) do
      resolve fn(_, _, _) ->
        {:ok, Repo.all(Following)}
      end
    end

    field(:profile, non_null(:profile)) do
      arg(:id, non_null(:id))
      resolve fn(_, %{id: id}, %{context: %{current_user: current_user}}) ->
        {:ok, Entity.get_profile(current_user, id)}
      end
    end

    field :profiles, list_of(:profile) do
      resolve fn(_, _, _) ->
        {:ok, Repo.all(Profile)}
      end
    end
  end

  object :following do
    field :id, :id
    field :name, :string
    field :avatar_url, :string
    field :social_link_id, :id
    field :profile_id, :id
  end

  object :social_link do
    field :id, :id
    field :name, :string
  end

  object :profile do
    field :id, :id
    field :avatar_url, :string
    field :name, :string

    field :followings, list_of(:following) do
      resolve fn(%Profile{} = profile, _, %{context: %{current_user: current_user}}) ->
        {:ok, Entity.list_profile_followings(current_user, profile)}
      end
    end

  end
end
