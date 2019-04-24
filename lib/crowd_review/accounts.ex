defmodule CrowdReview.Accounts do
  import Ecto.Query, warn: false

  alias CrowdReview.Accounts.{ReviewRequest, User}
  alias CrowdReview.Repo

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user_by_email(email) do
    query =
      from(
        u in User,
        join: c in assoc(u, :credential),
        where: c.email == ^email
      )

    query
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  def authenticate_by_email_and_password(email, password) do
    user = get_user_by_email(email)

    cond do
      user && Pbkdf2.verify_pass(password, user.credential.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Bcrypt.no_user_verify()
        {:error, :not_found}
    end
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def register_user(attrs \\ %{}) do
    result =
      %User{}
      |> User.registration_changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, user} ->
        user = Repo.preload(user, :credential)
        {:ok, user}

      error_result ->
        error_result
    end
  end

  def list_review_requests do
    Repo.all(ReviewRequest)
  end

  def create_review_request(attrs, nil = _user) do
    %ReviewRequest{}
    |> ReviewRequest.changeset(attrs)
    |> Repo.insert()
  end

  def create_review_request(attrs, %User{} = user) do
    user
    |> Ecto.build_assoc(:review_requests)
    |> ReviewRequest.changeset(attrs)
    |> Repo.insert()
  end

  def change_review_request(%ReviewRequest{} = review_request) do
    ReviewRequest.changeset(review_request, %{})
  end
end
