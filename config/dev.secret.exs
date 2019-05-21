use Mix.Config

config :profilo, :pow_assent,
  providers: [
    github: [
      client_id: "54fcf4d0d72ec4e8cf15",
      client_secret: "ea2c8bb18819816c0dbf3b993eb5dfdb3e41a2fb",
      strategy: Profilo.Github.Strategy
    ],
    twitter: [
      consumer_key: "LOzXHJZ0UTNQyX411jxklWPNd",
      consumer_secret: "v1CuBQNh057lpfWCv04ns0LEx39ArjejFAAQxXZGGcaVDWZFMY",
      strategy: PowAssent.Strategy.Twitter
    ]
  ]
