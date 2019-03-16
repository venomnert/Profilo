defmodule ProfiloWeb.Router do
  use ProfiloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ProfiloWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/auth", ProfiloWeb do
     pipe_through :browser
     get "/:provider", AuthController, :request
     get "/:provider/callback", AuthController, :callback
 end

  scope "/", ProfiloWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProfiloWeb do
  #   pipe_through :api
  # end
end
