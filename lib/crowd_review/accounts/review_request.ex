defmodule CrowdReview.Accounts.ReviewRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrowdReview.Accounts.User
  alias CrowdReview.Language

  schema "review_requests" do
    field :url, :string
    field :description, :string
    belongs_to :language, Language
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(review_request, attrs) do
    review_request
    |> cast(attrs, [:url, :description])
    |> cast_assoc(:language, with: &Language.changeset/2)
    |> validate_required([:url, :language])
  end
end
