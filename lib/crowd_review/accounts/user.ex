defmodule CrowdReview.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrowdReview.Accounts.{Credential, ReviewRequest}

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :review_requests, ReviewRequest

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
