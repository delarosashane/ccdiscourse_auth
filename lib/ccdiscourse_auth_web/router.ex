defmodule CcdiscourseAuthWeb.Router do
  use CcdiscourseAuthWeb, :router
  use Pow.Phoenix.Router
  use PhoenixOauth2Provider.Router, otp_app: :ccdiscourse_auth

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

  pipeline :api_protected do
    plug ExOauth2Provider.Plug.VerifyHeader, otp_app: :ccdiscourse_auth, realm: "Bearer"
    plug ExOauth2Provider.Plug.EnsureAuthenticated
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", CcdiscourseAuthWeb do
    pipe_through :browser

    get "/", PageController, :index

  end

  scope "/" do
    pipe_through [:browser, :protected]

    oauth_routes()
  end

  scope "/" do
    pipe_through :api

    oauth_api_routes()
  end

  scope "/api/v1", CcdiscourseAuthWeb.API.V1 do
    pipe_through [:api, :api_protected]

    resources "/accounts", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CcdiscourseAuthWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CcdiscourseAuthWeb.Telemetry
    end
  end
end
