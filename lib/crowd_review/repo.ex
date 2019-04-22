defmodule CrowdReview.Repo do
  use Ecto.Repo,
    otp_app: :crowd_review,
    adapter: Ecto.Adapters.Postgres
end
