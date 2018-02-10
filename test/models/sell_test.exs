defmodule CommodityGameApi.SellTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.Sell

  @valid_attrs %{amount: 42, open: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sell.changeset(%Sell{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sell.changeset(%Sell{}, @invalid_attrs)
    refute changeset.valid?
  end
end
