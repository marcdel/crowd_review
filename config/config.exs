# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :crowd_review,
  ecto_repos: [CrowdReview.Repo]

# Configures the endpoint
config :crowd_review, CrowdReviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Dv10UjgHtx3Z1Y0GS/E7m6GlzJWCmaIxo7YTKDZNVpRHx8OCMDwXheVhAcKym+YF",
  live_view: [signing_salt: "ft1br1lynRx3wBqBF7FHehWz8k3oDf+TUsLL5khAKSXA2vPj7hsfa8GhzJLnB47k"],
  render_errors: [view: CrowdReviewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CrowdReview.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use LiveView engine for leex files
config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
