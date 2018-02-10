defmodule CommodityGameApi.BuyTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.Buy

  @valid_attrs %{amount: 42, open: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Buy.changeset(%Buy{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Buy.changeset(%Buy{}, @invalid_attrs)
    refute changeset.valid?
  end
end
