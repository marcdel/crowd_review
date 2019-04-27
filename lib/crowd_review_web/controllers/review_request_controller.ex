defmodule CrowdReviewWeb.ReviewRequestController do
  use CrowdReviewWeb, :controller

  alias CrowdReview.Accounts
  alias CrowdReview.Accounts.ReviewRequest
  alias CrowdReviewWeb.Auth

  def index(conn, _params) do
    review_requests = Accounts.list_review_requests()
    render(conn, "index.html", review_requests: review_requests)
  end

  def new(conn, _params) do
    changeset = Accounts.change_review_request(%ReviewRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"review_request" => review_request_params}) do
    user = Auth.current_user(conn)

    case Accounts.create_review_request(review_request_params, user) do
      {:ok, _review_request} ->
        conn
        |> put_flash(:info, "Review request created successfully.")
        |> redirect(to: Routes.review_request_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
