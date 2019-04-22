defmodule CrowdReviewWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias CrowdReviewWeb.Router.Helpers, as: Routes
      alias CrowdReviewWeb.Auth

      # The default endpoint for testing
      @endpoint CrowdReviewWeb.Endpoint

      def sign_in(conn, user) do
        conn
        |> bypass_through(CrowdReviewWeb.Router, :browser)
        |> get(Routes.page_path(conn, :index))
        |> Auth.login(user)
        |> send_resp(:ok, "")
        |> recycle()
      end
    end
  end

  setup tags do
    :ok = Sandbox.checkout(CrowdReview.Repo)

    unless tags[:async] do
      Sandbox.mode(CrowdReview.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
