defmodule CommodityGameApi.CommodityItemTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.CommodityItem

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CommodityItem.changeset(%CommodityItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CommodityItem.changeset(%CommodityItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
