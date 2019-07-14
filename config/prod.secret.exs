use Mix.Config

config :profilo, :pow_assent,
  providers: [
    github: [
      client_id: "979ffe12cbea5df982f9",
      client_secret: "950af55352820f800c1233fdd20e35ce310b9e49",
      strategy: Profilo.Github.Strategy
    ],
    twitter: [
      consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
      consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
      strategy: Profilo.Twitter.Strategy
    ]
  ]
