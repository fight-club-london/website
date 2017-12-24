defmodule Ev2Web.Router do
  use Ev2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ev2Web.Auth, accounts: Ev2.Accounts

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ev2Web do
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
  scope "/", Ev2Web do
    pipe_through [:browser, :authenticate]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ev2Web do
  #   pipe_through :api
  # end
end
