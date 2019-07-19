defmodule ProfiloWeb.Schema do
  use Absinthe.Schema

  alias ProfiloWeb.{
            ResolverFollowing,
            ResolverFeedNode,
            ResolverProfile,
            ResolverSocialLink}

  query do

    @desc "Following item retrieved based id or name"
    field :following, non_null(:following) do
      arg :id, :integer
      arg :name, :string
      resolve &ResolverFollowing.get_following/3
    end

    @desc "List of following items by profile id/name"
    field :followings, list_of(:following) do
      arg :profile_id, :integer
      arg :profile_name, :string
      resolve &ResolverFollowing.list_followings/3
    end

    @desc "Get all the feed node by profile or social_links id/name"
    field :feed_nodes, list_of(:feed_node) do
      arg :profile_id, :integer
      arg :profile_name, :string
      arg :social_link_id, :integer
      arg :social_link_name, :string
      resolve &ResolverFeedNode.list_feed_node/3
    end

    @desc "Get a feed node by its id"
    field :feed_node, non_null(:feed_node) do
      arg :id, :integer
      resolve &ResolverFeedNode.get_feed_node/3
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

    field :update_profile, :profile do
      arg :id, non_null(:integer)
      arg :input, non_null(:profile_input)
      resolve &ResolverProfile.update_profile/3
    end

    field :link_following_to_profile, :profile do
      arg :id, non_null(:integer)
      arg :followings, non_null(list_of(:integer))
      resolve &ResolverProfile.link_following_to_profile/3
    end

    field :unlink_following_to_profile, :profile do
      arg :id, non_null(:integer)
      arg :followings, non_null(list_of(:integer))
      resolve &ResolverProfile.unlink_following_to_profile/3
    end
  end

  subscription do
    field :new_profile, :profile do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
    end
  end

  object :following do
    field :id, :id
    field :name, :string
    field :avatar_url, :string
    field :screen_name, :string
    field :social_link_id, :id
    field :profile_id, :id

    field :profile, non_null(:profile) do
      resolve &ResolverFollowing.get_profile/3
    end

    field :social_link, non_null(:social_link) do
      resolve &ResolverFollowing.get_social_link/3
    end
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

  object :feed_node do
    field :description, :string

    field :profile, non_null(:profile) do
      resolve &ResolverFeedNode.get_profile/3
    end

    field :social_link, non_null(:social_link) do
      resolve &ResolverFeedNode.get_social_link/3
    end

  end

  input_object :profile_input do
    field :name, non_null(:string)
    field :avatar_url, non_null(:string)
    field :followings, list_of(:integer)
  end

end
