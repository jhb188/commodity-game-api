defmodule CommodityGameApi.CommodityTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.Commodity

  @valid_attrs %{name: "some name", scarcity: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
