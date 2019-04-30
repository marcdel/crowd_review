defmodule CrowdReview.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrowdReview.{Language, Repo}

  schema "languages" do
    field :name, :string
    timestamps()
  end

  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def all do
    languages =
      Language
      |> Repo.all()
      |> Enum.map(fn language -> language.name end)

    ["" | languages]
  end
end
