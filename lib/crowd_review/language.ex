defmodule CrowdReview.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrowdReview.{Language, Repo}
  alias CrowdReview.Accounts.ReviewRequest

  schema "languages" do
    field :name, :string
    timestamps()
  end

  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def get_by_name(name) do
    Repo.get_by(Language, name: name)
  end

  def all do
    languages =
      Language
      |> Repo.all()
      |> Enum.map(fn language -> language.name end)

    ["" | languages]
  end
end
