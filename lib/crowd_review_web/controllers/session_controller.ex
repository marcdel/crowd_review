defmodule CrowdReviewWeb.SessionController do
  use CrowdReviewWeb, :controller
  alias CrowdReviewWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.login_by_email_and_password(conn, email, password) do
      {:ok, conn} ->
        user = Auth.current_user(conn)

        conn
        |> put_flash(:info, "Welcome back, #{user.name}!")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, :not_found, conn} ->
        conn
        |> put_flash(:error, "Oops, we couldn't find that email!")
        |> redirect(to: Routes.user_path(conn, :new))

      {:error, :unauthorized, conn} ->
        conn
        |> put_flash(:error, "Oops, the password you entered was incorrect!")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
