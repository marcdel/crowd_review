defmodule CrowdReview.Repo.Migrations.CreateReviewRequest do
  use Ecto.Migration

  def change do
    create table(:review_requests) do
      add :url, :text, null: false
      add :language, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all, null: true)

      timestamps()
    end

    create index(:review_requests, [:user_id])
  end
end
