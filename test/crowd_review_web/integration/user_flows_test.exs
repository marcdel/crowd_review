defmodule CrowdReviewWeb.UserFlowsTest do
  use CrowdReviewWeb.IntegrationCase, async: true

  @tag :integration
  test "user can register, log in, and view their profile", %{conn: conn} do
    conn =
      conn
      |> get(Routes.user_path(conn, :new))
      |> follow_form(%{
        user: %{
          name: "User One",
          username: "user1",
          credential: %{
            email: "user1@email.com",
            password: "password"
          }
        }
      })

    user = CrowdReviewWeb.Auth.current_user(conn)

    conn
    |> assert_response(
      status: 200,
      html: "User One created!",
      path: Routes.user_path(conn, :show, user.id)
    )
    |> follow_link(Routes.session_path(conn, :delete, user.id), method: :delete)
    |> follow_link("Log in")
    |> follow_form(%{
      session: %{
        email: "user1@email.com",
        password: "password"
      }
    })
    |> assert_response(
      status: 200,
      html: "Welcome back, User One!",
      path: Routes.user_path(conn, :show, user.id)
    )
  end

  @tag :integration
  test "user can create a new review request and see it in the list", %{conn: conn} do
    conn
    |> get(Routes.page_path(conn, :index))
    |> follow_link("Get a Review")
    |> assert_response(status: 200, path: Routes.review_request_path(conn, :new))
    |> follow_form(%{
      review_request: %{
        url: "https://github.com/phoenixframework/phoenix/pull/3327",
        language: "javascript"
      }
    })
    |> assert_response(
      status: 200,
      html: "https://github.com/phoenixframework/phoenix/pull/3327",
      path: Routes.review_request_path(conn, :index)
    )
  end
end
