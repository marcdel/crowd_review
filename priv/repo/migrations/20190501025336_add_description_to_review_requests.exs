defmodule CrowdReview.Repo.Migrations.AddDescriptionToReviewRequests do
  use Ecto.Migration

  def change do
    alter table(:review_requests) do
      add :description, :text, null: true
    end
  end
end
