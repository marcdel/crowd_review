defmodule CrowdReviewWeb.UserController do
  use CrowdReviewWeb, :controller

  alias CrowdReview.Accounts
  alias CrowdReview.Accounts.User
  alias CrowdReviewWeb.Auth

  plug :authenticate_user when action in [:show]

  def show(conn, params) do
    if Auth.it_me?(conn, params) do
      user = Auth.current_user(conn)
      render(conn, "show.html", user: user)
    else
      conn
      |> put_flash(:error, "That ain't you, friend")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
