defmodule Launchstats.Router do
  use Launchstats.Web, :router

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

  scope "/", Launchstats do
    pipe_through :browser # Use the default browser stack
    
    #get "/", StatsController, :index
    get "/", PageController, :index
    get "/stats", StatsController, :index
    get "/stats/historical", StatsController, :historical
    get "/stats/search", StatsController, :search
    get "/stats/:id", StatsController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Launchstats do
  #   pipe_through :api
  # end
end
