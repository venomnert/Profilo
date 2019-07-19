defmodule ProfiloWeb.ResolverFeedNode do
  alias Profilo.Entity
  alias Profilo.Entity.Lib.FeedNode

  def list_feed_node(_, %{profile_id: id}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, id)
    {:ok, Entity.list_profile_feed_node(current_user, profile) }
  end
  def list_feed_node(_, %{profile_name: name}, %{context: %{current_user: current_user}}) do
    profile = Entity.get_profile(current_user, name)
    {:ok, Entity.list_profile_feed_node(current_user, profile) }
  end
  def list_feed_node(_, %{social_link_id: id}, %{context: %{current_user: current_user}}) do
    social_link = Entity.get_social_link(id)
    {:ok, Entity.list_social_link_feed_node(current_user, social_link) }
  end
  def list_feed_node(_, %{social_link_name: name}, %{context: %{current_user: current_user}}) do
    social_link = Entity.get_social_link(name)
    {:ok, Entity.list_social_link_feed_node(current_user, social_link) }
  end

  def get_feed_node(_, %{id: id}, %{context: %{current_user: current_user}}) do
    case Entity.get_feed_node(current_user, id) do
      nil     -> {:error, %{message: "No feed node"}}
      result  -> {:ok, result}
    end
  end
  def get_profile(%FeedNode{} = feed_node, _, %{context: %{current_user: current_user}}) do
    case Entity.get_profile(current_user, feed_node.profile_id) do
      nil     -> {:error, Entity.create_profile(current_user, %{})}
      result  -> {:ok, result}
    end
  end
  def get_social_link(%FeedNode{} = feed_node, _, %{context: %{current_user: _current_user}}) do
    case Entity.get_social_link(feed_node.social_link_id) do
      nil     -> {:error, %{}}
      result  -> {:ok, result}
    end
  end

end
