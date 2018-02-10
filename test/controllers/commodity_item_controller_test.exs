defmodule CommodityGameApi.CommodityItemControllerTest do
  use CommodityGameApi.ConnCase

  alias CommodityGameApi.CommodityItem
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, commodity_item_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    commodity_item = Repo.insert! %CommodityItem{}
    conn = get conn, commodity_item_path(conn, :show, commodity_item)
    assert json_response(conn, 200)["data"] == %{"id" => commodity_item.id,
      "commodity_id" => commodity_item.commodity_id,
      "user_id" => commodity_item.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, commodity_item_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, commodity_item_path(conn, :create), commodity_item: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CommodityItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, commodity_item_path(conn, :create), commodity_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    commodity_item = Repo.insert! %CommodityItem{}
    conn = put conn, commodity_item_path(conn, :update, commodity_item), commodity_item: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CommodityItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    commodity_item = Repo.insert! %CommodityItem{}
    conn = put conn, commodity_item_path(conn, :update, commodity_item), commodity_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    commodity_item = Repo.insert! %CommodityItem{}
    conn = delete conn, commodity_item_path(conn, :delete, commodity_item)
    assert response(conn, 204)
    refute Repo.get(CommodityItem, commodity_item.id)
  end
end
