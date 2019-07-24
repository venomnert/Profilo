defmodule Profilo.Twitter do
  # In order for this context to work the developer must
  # create a consumer_key and consumer_secret on twitter and add it to
  # Profilo/config/dev.secret.exs

  alias Profilo.{Accounts, Entity}
  alias Profilo.Accounts.Lib.{User, UserIdentity}
  @twitter_following_count 200
  @twitter_timeline_count 2

  def get_update(%User{}= user) do
    Accounts.get_user_identity!(user, "twitter")
    |> set_config()
    |> get_following(user)
    |> get_feed_node(user)
    |> IO.inspect(label: "finished with following message")
  end

  def get_timeline(%{oauth_token: nil, oauth_token_secret: nil}), do: {:error, "Not logged into Twitter"}
  def get_timeline(curr_user) do
    set_config(curr_user)
    try do
      {:ok, ExTwitter.request(:get, "1.1/statuses/home_timeline.json")}
    rescue
      e in ExTwitter.ConnectionError -> {:error, e.message}
      e in ExTwitter.RateLimitExceededError -> {:error, e.message}
    end
  end

  ########### Request following and create following ###########
  def get_following(%UserIdentity{} = user_identity, %User{} = user) do
    try do
      ExTwitter.request(:get, "1.1/friends/list.json", [screen_name: user_identity.screen_name, count: @twitter_following_count])
      |> add_followings_to_profilo(user)
      |> get_next_followings(user_identity, user)
    rescue
      e in ExTwitter.ConnectionError -> {:error, e.message}
      e in ExTwitter.RateLimitExceededError -> {:error, e.message}
    end
  end

  defp get_next_followings(%{next_cursor: 0}, %UserIdentity{} = user_identity, %User{} = _user), do: user_identity

  defp get_next_followings(%{next_cursor: next_cursor}, %UserIdentity{} = user_identity, %User{} = user)  do
    try do
      ExTwitter.request(:get, "1.1/friends/list.json", [cursor: next_cursor, screen_name: user_identity.screen_name, count: @twitter_following_count])
      |> add_followings_to_profilo(user)
      |> get_next_followings(user_identity, user)
    rescue
      e in ExTwitter.ConnectionError -> {:error, e.message}
      e in ExTwitter.RateLimitExceededError -> {:error, e.message}
    end
  end

  def add_followings_to_profilo(data, %User{} = user) do
    data.users
    |> Enum.each(fn single_following ->
      case Entity.create_twitter_following(user, single_following) do
        {:ok, _} -> "Following created"
        {:error, %Ecto.Changeset{}} -> "Following already exisits"
      end
    end)

    data
  end

  ########### Request timeline and create feed node ###########
  def get_feed_node({:error, e}), do: e.message

  def get_feed_node(%UserIdentity{} = user_identity, %User{} = user) do
    set_config(user_identity)
    try do
      ExTwitter.request(:get, "1.1/statuses/home_timeline.json", [count: @twitter_timeline_count, exclude_replies: true, include_entities: false])
      |> add_feed_node_to_profilo(user)
    rescue
      e in ExTwitter.ConnectionError -> {:error, e.message}
      e in ExTwitter.RateLimitExceededError -> {:error, e.message}
    end
  end

  def add_feed_node_to_profilo(data, %User{} = user) do
    Entity.get_profiles_by_social_link(user, "twitter")
    |> Enum.each(fn profile ->
        profile
        |> get_following_by_social_link(user, "twitter")
        |> get_node_by_following(data)
        |> create_twitter_feed_node(user, profile)
      end)
    data
  end

  defp get_following_by_social_link(profile, user, social_link) do
    Entity.get_following_by_social_link(user, profile, social_link)
  end

  defp get_node_by_following(twitter_followings, data) do
    twitter_followings
    |> Enum.map(fn following ->
        data
        |> Enum.filter(fn feed ->
          # IO.inspect(feed.user.screen_name, label: "FEED NAME")
          # IO.inspect(following.screen_name, label: "FOLLOWING NAME")
          feed.user.screen_name == following.screen_name
        end)
      end)
    |> List.flatten()
  end

  defp create_twitter_feed_node(nil, _user, _profile), do: {:error, "No feed node"}

  defp create_twitter_feed_node(data, user, profile) do
    data
    |> Enum.each(fn feed ->
      attr = %{description: feed.text}
      Entity.create_twitter_feed_node(user, profile, attr)
    end)
  end

  ########### Twitter Config ###########
  defp set_config(curr_user) do
    ExTwitter.configure(:process, [
      consumer_key: Application.get_env(:profilo, :pow_assent)[:providers][:twitter][:consumer_key],
      consumer_secret: Application.get_env(:profilo, :pow_assent)[:providers][:twitter][:consumer_secret],
      access_token: curr_user.oauth_token,
      access_token_secret: curr_user.oauth_token_secret
    ])
    curr_user
  end
end
