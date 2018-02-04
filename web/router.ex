defmodule CommodityGameApi.Router do
  use CommodityGameApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CommodityGameApi do
    pipe_through :api

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
  end
end
