defmodule Ev2Web.Router do
  use Ev2Web, :router

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

  scope "/", Ev2Web do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController, only: [:index, :new, :create, :edit, :update, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ev2Web do
  #   pipe_through :api
  # end
end
