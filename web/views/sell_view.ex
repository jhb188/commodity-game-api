defmodule CommodityGameApi.SellView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{sells: sells}) do
    %{data: render_many(sells, CommodityGameApi.SellView, "sell.json")}
  end

  def render("show.json", %{sell: sell}) do
    %{data: render_one(sell, CommodityGameApi.SellView, "sell.json")}
  end

  def render("sell.json", %{sell: sell}) do
    %{id: sell.id,
      commodity_id: sell.commodity_id,
      user_id: sell.user_id,
      commodity_item_id: sell.commodity_item_id,
      amount: sell.amount,
    }
  end
end
