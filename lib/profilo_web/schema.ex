defmodule ProfiloWeb.Schema do
  use Absinthe.Schema

  alias ProfiloWeb.{ResolverFollowing, ResolverProfile, ResolverSocialLink}

  query do

    @desc "Following item retrieved based id or name"
    field :following, non_null(:following) do
      arg :id, :integer
      arg :name, :string
      resolve &ResolverFollowing.get_following/3
    end

    @desc "List of following items by profile id"
    field :followings, list_of(:following) do
      arg :profile_id, :integer
      arg :profile_name, :string
      resolve &ResolverFollowing.get_following/3
    end

    field :profile, non_null(:profile) do
      arg :id, :integer
      arg :name, :string
      resolve &ResolverProfile.get_profile/3
    end

    field :profiles, list_of(:profile) do
      resolve &ResolverProfile.get_profile/3
    end

    field :social_link, non_null(:social_link) do
      arg(:name, non_null(:string))
      resolve &ResolverSocialLink.get_social_link/3
    end

    field :social_links, list_of(:social_link) do
      resolve &ResolverSocialLink.get_social_link/3
    end
  end

  mutation do
    field :create_profile, :profile do
      arg :input, non_null(:profile_input)
      resolve &ResolverProfile.create_profile/3
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
      resolve &ResolverProfile.list_profile_followings/3
    end

  end

  input_object :profile_input do
    field :name, non_null(:string)
    field :avatar_url, non_null(:string)
  end
end
