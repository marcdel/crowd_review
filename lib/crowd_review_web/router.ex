defmodule CrowdReviewWeb.Router do
  use CrowdReviewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CrowdReviewWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CrowdReviewWeb do
    pipe_through :browser

    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  scope "/auth", CrowdReviewWeb do
    pipe_through(:browser)

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrowdReviewWeb do
  #   pipe_through :api
  # end
end
