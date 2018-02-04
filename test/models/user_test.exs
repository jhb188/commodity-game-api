defmodule CommodityGameApi.UserTest do
  use CommodityGameApi.ModelCase

  alias CommodityGameApi.User

  @valid_attrs %{currency_units: 42, email: "some email", password_hash: "some password_hash", username: "some username"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
