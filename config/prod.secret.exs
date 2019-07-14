use Mix.Config

config :profilo, :pow_assent,
  providers: [
    github: [
      client_id: "bc93ca24330b5030f388",
      client_secret: "4f864e2ca3b20d81773c33786b16cd2f910af89c",
      strategy: Profilo.Github.Strategy
    ],
    twitter: [
      consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
      consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
      strategy: Profilo.Twitter.Strategy
    ]
  ]
