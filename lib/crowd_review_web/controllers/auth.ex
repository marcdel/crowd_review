defmodule CrowdReviewWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias CrowdReview.Accounts
  alias CrowdReviewWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def it_me?(conn, %{"id" => id}) when is_binary(id) do
    {id, _} = Integer.parse(id)
    it_me?(conn, %{"id" => id})
  end

  def it_me?(conn, %{"id" => id}) when is_integer(id) do
    %{id: user_id} = current_user(conn)
    user_id == id
  end

  def login(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_password(conn, email, password) do
    case Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, user} -> {:ok, login(conn, user)}
      {:error, :unauthorized} -> {:error, :unauthorized, conn}
      {:error, :not_found} -> {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def current_user(conn) do
    conn.assigns.current_user
  end

  defp put_current_user(conn, user) do
    token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:current_user, user)
    |> assign(:user_token, token)
  end
end
