defmodule PhoenixBoilerplateWeb.SessionControllerTest do
  use PhoenixBoilerplateWeb.ConnCase, async: true

  test "GET /sessions/new", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :new))
    assert html_response(conn, 200) =~ "Email"
    assert html_response(conn, 200) =~ "Password"
  end

  describe "POST /sessions" do
    test "redirects to registration page when user is not registered", %{conn: conn} do
      conn =
        post(conn, Routes.session_path(conn, :create),
          session: %{"email" => "unregistered@email.com", "password" => "password"}
        )

      assert get_flash(conn, :error) =~ "Oops, we couldn't find that email!"
      assert redirected_to(conn) == Routes.user_path(conn, :create)
    end

    test "redirects to user's profile page when user is registered", %{conn: conn} do
      user =
        Fixtures.registered_user(%{
          name: "Marc",
          credential: %{
            email: "marcdel@email.com",
            password: "password"
          }
        })

      conn =
        post(conn, Routes.session_path(conn, :create),
          session: %{"email" => "marcdel@email.com", "password" => "password"}
        )

      assert get_flash(conn, :info) =~ "Welcome back, Marc!"
      assert redirected_to(conn) == Routes.user_path(conn, :show, user.id)
    end
  end

  test "POST /sessions with invalid password", %{conn: conn} do
    Fixtures.registered_user(%{
      name: "Marc",
      credential: %{
        email: "marcdel@email.com",
        password: "password"
      }
    })

    invalid_session = %{
      "email" => "marcdel@email.com",
      "password" => "wrong password"
    }

    create_conn = post(conn, Routes.session_path(conn, :create), session: invalid_session)

    # Can't get_flash for some reason, so have to assert on the html response
    assert html_response(create_conn, 200) =~ "Oops, the password you entered was incorrect!"
  end

  test "DELETE /sessions", %{conn: conn} do
    user = %{id: 1}
    conn = sign_in(conn, user)

    conn = delete(conn, Routes.session_path(conn, :delete, user.id))

    assert get_flash(conn, :info) =~ "Logged out."
    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
