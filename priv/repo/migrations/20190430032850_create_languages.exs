defmodule CrowdReview.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
