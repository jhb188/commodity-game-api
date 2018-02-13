defmodule CommodityGameApi.BuyView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{buys: buys}) do
    %{data: render_many(buys, CommodityGameApi.BuyView, "buy_with_username.json")}
  end

  def render("show.json", %{buy: buy}) do
    %{data: render_one(buy, CommodityGameApi.BuyView, "buy.json")}
  end

  def render("buy.json", %{buy: buy}) do
    %{
      id: buy.id,
      commodity_id: buy.commodity_id,
      user_id: buy.user_id,
      amount: buy.amount,
    }
  end

  def render("buy_with_username.json", %{buy: buy}) do
    %{
      id: buy.id,
      commodity_id: buy.commodity_id,
      username: buy.username,
      amount: buy.amount,
    }
  end
end
