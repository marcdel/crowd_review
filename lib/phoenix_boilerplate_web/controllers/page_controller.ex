defmodule PhoenixBoilerplateWeb.PageController do
  use PhoenixBoilerplateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
