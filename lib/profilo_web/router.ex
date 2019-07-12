defmodule ProfiloWeb.Router do
  use ProfiloWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

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

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_assent_routes()

    get "/uikit", ProfiloWeb.PageController, :uikit
  end


  scope "/", ProfiloWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ProfiloWeb.Schema,
      interface: :simple
  end

  scope "/api", ProfiloWeb do
    pipe_through [:api, :protected]

    get "/:provider", PageController, :get_user
    get "/auth/:provider", PageController, :is_auth
    get "/followers/:provider", PageController, :followers

  end

end
