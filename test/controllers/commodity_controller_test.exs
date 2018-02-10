defmodule CommodityGameApi.CommodityControllerTest do
  use CommodityGameApi.ConnCase

  alias CommodityGameApi.Commodity
  @valid_attrs %{name: "some name", scarcity: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, commodity_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    commodity = Repo.insert! %Commodity{}
    conn = get conn, commodity_path(conn, :show, commodity)
    assert json_response(conn, 200)["data"] == %{"id" => commodity.id,
      "name" => commodity.name,
      "scarcity" => commodity.scarcity,
      "commodity_set_id" => commodity.commodity_set_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, commodity_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, commodity_path(conn, :create), commodity: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Commodity, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, commodity_path(conn, :create), commodity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    commodity = Repo.insert! %Commodity{}
    conn = put conn, commodity_path(conn, :update, commodity), commodity: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Commodity, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    commodity = Repo.insert! %Commodity{}
    conn = put conn, commodity_path(conn, :update, commodity), commodity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    commodity = Repo.insert! %Commodity{}
    conn = delete conn, commodity_path(conn, :delete, commodity)
    assert response(conn, 204)
    refute Repo.get(Commodity, commodity.id)
  end
end
