defmodule ProfiloWeb.Schema do
  use Absinthe.Schema

  alias Profilo.Entity
  alias Profilo.Entity.Lib.{Following, Profile}
  alias Profilo.Repo
  alias ProfiloWeb.Resolvers

  query do

    field(:following, non_null(:following)) do
      arg :id, :id
      arg :name, :string
      resolve &Resolvers.get_following/3
    end

    field :followings, list_of(:following) do
      resolve fn(_, _, _) ->
        {:ok, Repo.all(Following)}
      end
    end

    field(:profile, non_null(:profile)) do
      arg :id, :id
      arg :name, :string
      resolve &Resolvers.get_profile/3
    end

    field :profiles, list_of(:profile) do
      resolve fn(_, _, _) ->
        {:ok, Repo.all(Profile)}
      end
    end

    field :social_link, non_null(:social_link) do
      arg(:name, non_null(:string))
      resolve fn(_, %{name: name}, _) ->
        {:ok, Entity.get_social_link(name)}
      end
    end

    field :social_links, list_of(:social_link) do
      resolve fn(_, _, _) ->
        {:ok, Entity.list_social_links()}
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
