defmodule Profilo.TwitterTest do
  use Profilo.DataCase

  alias Profilo.Twitter
  alias Profilo.Entity
  alias Profilo.Entity.Lib.{Following, Profile, SocialLink}
  alias Profilo.Test.UserTestHelper

  @valid__user_attrs %{
    email: "test@gmail.com",
    password: "1234567890",
    current_password: "1234567890",
    confirm_password: "1234567890",
    address: "some address",
    company: "some company",
    first_name: "some first_name",
    last_name: "some last_name",
    phone_number: "some phone_number",
    website: "some website"
  }
  @valid_profile_attrs %{
    name: "Wes Bos",
    avatar_url: "https://profilo.app"
  }
  @valid_following_attrs %{
    name: "Wes Bos",
    avatar_url:  "https://avatars1.githubusercontent.com/u/150330?v=4",
    screen_name: "wesbos"
  }
  @valid_social_link_attrs %{
    name: "twitter",
  }
  @valid_twitter_following_api_data %{
    users: [
      %ExTwitter.Model.User{
      listed_count: 3085,
      location: "",
      profile_link_color: "3B94D9",
      notifications: false,
      utc_offset: nil,
      profile_background_color: "C0DEED",
      lang: nil,
      email: nil,
      following: true,
      profile_use_background_image: true,
      is_translation_enabled: false,
      profile_image_url_https: "https://avatars1.githubusercontent.com/u/150330?v=4",
      description: "Making confident traders since 2009! Join the 'Art Of Trading' community today! \n\nhttps://t.co/Dp8OvaAgdi\n\nFree Blog: https://t.co/sCi8fDzBJB",
      withheld_in_countries: nil,
      profile_background_tile: true,
      id_str: "52166809",
      default_profile_image: false,
      profile_background_image_url_https: "https://abs.twimg.com/images/themes/theme14/bg.gif",
      is_translator: false,
      profile_image_url: "http://pbs.twimg.com/profile_images/289088205/stewie_normal.jpg",
      favourites_count: 100098,
      profile_sidebar_border_color: "FFFFFF",
      contributors_enabled: false,
      profile_banner_url: "https://pbs.twimg.com/profile_banners/52166809/1469956814",
      show_all_inline_media: nil,
      geo_enabled: false,
      followers_count: 115751,
      follow_request_sent: false,
      id: 52166809,
      statuses_count: 114031,
      friends_count: 485,
      withheld_scope: nil,
      protected: false,
      screen_name: "wes bos",
      verified: false,
      profile_text_color: "333333",
      created_at: "Mon Jun 29 19:51:49 +0000 2009",
      time_zone: nil,
      default_profile: false,
      url: "https://t.co/8I93fZfpr3",
      name: "Wes Bos",
      profile_sidebar_fill_color: "DDEEF6",
      profile_background_image_url: "http://abs.twimg.com/images/themes/theme14/bg.gif"
      }
    ]
  }
  @valid_twitter_feed_node_api_data [
    %{
      contributors: nil,
      coordinates: nil,
      created_at: "Tue Jul 23 19:16:03 +0000 2019",
      favorite_count: 28,
      favorited: false,
      geo: nil,
      id: 1153745610102718465,
      id_str: "1153745610102718465",
      in_reply_to_screen_name: nil,
      in_reply_to_status_id: nil,
      in_reply_to_status_id_str: nil,
      in_reply_to_user_id: nil,
      in_reply_to_user_id_str: nil,
      is_quote_status: true,
      lang: "en",
      place: nil,
      possibly_sensitive: false,
      possibly_sensitive_appealable: false,
      quoted_status_id: 1153545277413838849,
      quoted_status_id_str: "1153545277413838849",
      retweet_count: 3,
      retweeted: false,
      source: "<a href=\"https://mobile.twitter.com\" rel=\"nofollow\">Twitter Web App</a>",
      text: "you're middle-aged now harry https://t.co/nGCyBtGs8a",
      truncated: false,
      user: %{
        notifications: false,
        profile_background_image_url_https: "https://abs.twimg.com/images/themes/theme14/bg.gif",
        profile_use_background_image: true,
        statuses_count: 5413,
        listed_count: 4374,
        follow_request_sent: false,
        id_str: "564919357",
        following: true,
        profile_link_color: "009999",
        geo_enabled: false,
        time_zone: nil,
        profile_image_url_https: "https://avatars1.githubusercontent.com/u/150330?v=4",
        profile_background_color: "131516",
        description: "The Vista of Twitter accounts  adeveloper1@gmail.com | DM | Merch: https://t.co/Fv5n2yAXPS | 💰 in tweet = ad",
        is_translator: false,
        created_at: "Fri Apr 27 21:06:51 +0000 2012",
        profile_sidebar_fill_color: "EFEFEF",
        contributors_enabled: false,
        utc_offset: nil,
        is_translation_enabled: false,
        profile_sidebar_border_color: "EEEEEE",
        location: "Localhost",
        screen_name: "wesbos"
      }
    }
  ]

  setup do
    user = UserTestHelper.user_fixture(@valid__user_attrs)
    {:ok, user: user}
  end

  test "get_following/3 create following", state do
    {:ok, %SocialLink{} = _social_link} = Entity.create_social_link(@valid_social_link_attrs)
    {:ok, %Profile{} = _profile} = Entity.create_profile(state[:user], @valid_profile_attrs)

    add_followings_to_profilo(@valid_twitter_following_api_data, state[:user])

    added_following = Entity.get_following(state[:user], "Wes Bos")

    assert added_following.name == @valid_following_attrs.name
    assert added_following.avatar_url == @valid_following_attrs.avatar_url
  end

  test "get_feed_node/3 create feed nodes", state do
    {:ok, %SocialLink{} = social_link} = Entity.create_social_link(@valid_social_link_attrs)
    {:ok, %Following{} = following} = Entity.create_following(state[:user], social_link, @valid_following_attrs)
    {:ok, %Profile{} = profile} = Entity.create_profile(state[:user], @valid_profile_attrs)
    Entity.add_following_to_profile(state[:user], profile, following)

    Twitter.add_feed_node_to_profilo(@valid_twitter_feed_node_api_data, state[:user])
    added_feed_node = Entity.list_profile_feed_node(state[:user], profile) |> List.first()

    assert added_feed_node.description == @valid_twitter_feed_node_api_data |> List.first() |> Map.get(:text)

  end

  defp add_followings_to_profilo(data, user) do
    data.users
    |> Enum.each(fn single_following ->
      case Entity.create_twitter_following(user, single_following) do
        {:ok, _} -> "Following created"
        {:error, %Ecto.Changeset{}} -> "Following already exisits"
      end
    end)
  end

end
