defmodule LfcWeb.Router do
  use LfcWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LfcWeb.Auth, accounts: Lfc.Accounts

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LfcWeb do
    pipe_through :browser # Use the default browser stack

    resources "/", DashboardController, only: [:index]
    resources "/users", UserController, except: [:delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/password", PasswordController, except: [:delete, :show, :index]
    get "/verification/:hash", VerificationController, :verify
    get "/verification/verify/:hash", VerificationController, :verify_again
    get "/verification/resend/:hash", VerificationController, :resend
  end

  # authed routes
  scope "/", LfcWeb do
    pipe_through [:browser, :authenticate]

    resources "/dashboard", AdminDashboardController, only: [:index]
    resources "/events", EventController, only: [:create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LfcWeb do
  #   pipe_through :api
  # end
end
