defmodule CommodityGameApi.CommodityView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{commodities: commodities}) do
    %{data: render_many(commodities, CommodityGameApi.CommodityView, "commodity.json")}
  end

  def render("show.json", %{commodity: commodity}) do
    %{data: render_one(commodity, CommodityGameApi.CommodityView, "commodity.json")}
  end

  def render("commodity.json", %{commodity: commodity}) do
    %{id: commodity.id,
      name: commodity.name,
      scarcity: commodity.scarcity,
      commodity_set_id: commodity.commodity_set_id}
  end
end
