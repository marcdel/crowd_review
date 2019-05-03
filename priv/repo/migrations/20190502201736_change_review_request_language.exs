defmodule CrowdReview.Repo.Migrations.ChangeReviewRequestLanguage do
  use Ecto.Migration

  def change do
    alter table(:review_requests) do
      remove :language
      add :language_id, references(:languages, on_delete: :nothing, null: false)
    end
  end
end
