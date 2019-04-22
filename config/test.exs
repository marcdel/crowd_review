use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :crowd_review, CrowdReviewWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :crowd_review, CrowdReview.Repo,
  username: "postgres",
  password: "postgres",
  database: "crowd_review_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :phoenix_integration,
  endpoint: CrowdReviewWeb.Endpoint
