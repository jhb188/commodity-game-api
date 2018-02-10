defmodule CommodityGameApi.SellControllerTest do
  use CommodityGameApi.ConnCase

  alias CommodityGameApi.Sell
  @valid_attrs %{amount: 42, open: true}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sell_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sell = Repo.insert! %Sell{}
    conn = get conn, sell_path(conn, :show, sell)
    assert json_response(conn, 200)["data"] == %{"id" => sell.id,
      "commodity_id" => sell.commodity_id,
      "user_id" => sell.user_id,
      "commodity_item_id" => sell.commodity_item_id,
      "amount" => sell.amount,
      "open" => sell.open}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sell_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sell_path(conn, :create), sell: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Sell, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sell_path(conn, :create), sell: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sell = Repo.insert! %Sell{}
    conn = put conn, sell_path(conn, :update, sell), sell: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Sell, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sell = Repo.insert! %Sell{}
    conn = put conn, sell_path(conn, :update, sell), sell: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sell = Repo.insert! %Sell{}
    conn = delete conn, sell_path(conn, :delete, sell)
    assert response(conn, 204)
    refute Repo.get(Sell, sell.id)
  end
end
