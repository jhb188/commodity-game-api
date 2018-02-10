defmodule CommodityGameApi.CommoditySetView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{commodity_sets: commodity_sets}) do
    %{data: render_many(commodity_sets, CommodityGameApi.CommoditySetView, "commodity_set.json")}
  end

  def render("show.json", %{commodity_set: commodity_set}) do
    %{data: render_one(commodity_set, CommodityGameApi.CommoditySetView, "commodity_set.json")}
  end

  def render("commodity_set.json", %{commodity_set: commodity_set}) do
    %{id: commodity_set.id,
      name: commodity_set.name}
  end
end
