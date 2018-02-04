defmodule CommodityGameApi.Router do
  use CommodityGameApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", CommodityGameApi do
    pipe_through :api

    post "/sessions", SessionsController, :create
    delete "/sessions", SessionsController, :delete

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
  end
end
