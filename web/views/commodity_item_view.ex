defmodule CommodityGameApi.CommodityItemView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{commodity_items: commodity_items}) do
    %{data: render_many(commodity_items, CommodityGameApi.CommodityItemView, "commodity_item.json")}
  end

  def render("show.json", %{commodity_item: commodity_item}) do
    %{data: render_one(commodity_item, CommodityGameApi.CommodityItemView, "commodity_item.json")}
  end

  def render("commodity_item.json", %{commodity_item: commodity_item}) do
    %{id: commodity_item.id,
      commodity_id: commodity_item.commodity_id,
      user_id: commodity_item.user_id}
  end
end
