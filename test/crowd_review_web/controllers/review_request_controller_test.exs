defmodule CrowdReviewWeb.ReviewRequestControllerTest do
  use CrowdReviewWeb.ConnCase, async: true

  alias CrowdReview.Accounts
  alias CrowdReview.Repo

  @create_attrs %{
    language: %{name: "Elixir"},
    url: "github.com/test/pr/1",
    description: "need help with pattern matching"
  }
  @invalid_attrs %{language: nil, url: nil}

  describe "index" do
    test "lists all review_request", %{conn: conn} do
      {:ok, _} =
        Accounts.create_review_request(
          %{language: %{name: "Elixir"}, url: "github.com/test/pr/1", description: "desc1"},
          nil
        )

      {:ok, _} =
        Accounts.create_review_request(
          %{language: %{name: "Elm"}, url: "github.com/test/pr/2", description: "desc2"},
          nil
        )

      conn = get(conn, Routes.review_request_path(conn, :index))
      assert html_response(conn, 200) =~ "github.com/test/pr/1"
      assert html_response(conn, 200) =~ "github.com/test/pr/2"
      assert html_response(conn, 200) =~ "Elixir"
      assert html_response(conn, 200) =~ "Elm"
      assert html_response(conn, 200) =~ "desc1"
      assert html_response(conn, 200) =~ "desc2"
    end
  end

  describe "new review_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.review_request_path(conn, :new))
      assert html_response(conn, 200) =~ "Url"
      assert html_response(conn, 200) =~ "Language"
      assert html_response(conn, 200) =~ "Description"
    end
  end

  describe "create review_request" do
    test "redirects to index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.review_request_path(conn, :create), review_request: @create_attrs)

      assert redirected_to(conn) == Routes.review_request_path(conn, :index)

      conn = get(conn, Routes.review_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Elixir"
      assert html_response(conn, 200) =~ "github.com/test/pr/1"
      assert html_response(conn, 200) =~ "need help with pattern matching"
    end

    test "creates review requests for logged in users", %{conn: conn} do
      user = Fixtures.registered_user()
      conn = sign_in(conn, user)
      conn = post(conn, Routes.review_request_path(conn, :create), review_request: @create_attrs)

      assert redirected_to(conn) == Routes.review_request_path(conn, :index)

      user =
        user.id
        |> Accounts.get_user()
        |> Repo.preload(:review_requests)

      [%{url: url}] = user.review_requests
      assert url == "github.com/test/pr/1"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.review_request_path(conn, :create), review_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops"
    end
  end
end
