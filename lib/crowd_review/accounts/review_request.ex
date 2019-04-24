defmodule CrowdReview.Accounts.ReviewRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrowdReview.Accounts.User

  schema "review_requests" do
    field :language, :string
    field :url, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(review_request, attrs) do
    review_request
    |> cast(attrs, [:url, :language])
    |> validate_required([:url, :language])
  end
end
