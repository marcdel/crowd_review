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
end
