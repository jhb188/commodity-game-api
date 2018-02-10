defmodule CommodityGameApi.CommoditySetTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.CommoditySet

  @valid_attrs %{name: "some name", s: "some s"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CommoditySet.changeset(%CommoditySet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CommoditySet.changeset(%CommoditySet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
