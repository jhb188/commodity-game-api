defmodule CommodityGameApi.Router do
  use CommodityGameApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ProperCase.Plug.SnakeCaseParams
  end

  pipeline :authenticated do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api/v1", CommodityGameApi do
    pipe_through :api

    post "/signup", UserController, :create
    post "/login", SessionsController, :create

    pipe_through :authenticated

    get "/commodity-sets", CommoditySetController, :index

    get "/commodities", CommodityController, :index

    get "/commodity-items", CommodityItemController, :index

    get "/sells", SellController, :index
    post "/sells", SellController, :create
    put "/sells", SellController, :update

    get "/buys", BuyController, :index
    post "/buys", BuyController, :create

    get "/transactions", TransactionController, :index
    post "/transactions", TransactionController, :create
  end
end
