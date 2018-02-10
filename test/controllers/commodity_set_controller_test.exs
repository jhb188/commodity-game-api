defmodule CommodityGameApi.CommoditySetControllerTest do
  use CommodityGameApi.ConnCase

  alias CommodityGameApi.CommoditySet
  @valid_attrs %{name: "some name", s: "some s"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, commodity_set_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    commodity_set = Repo.insert! %CommoditySet{}
    conn = get conn, commodity_set_path(conn, :show, commodity_set)
    assert json_response(conn, 200)["data"] == %{"id" => commodity_set.id,
      "s" => commodity_set.s,
      "name" => commodity_set.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, commodity_set_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, commodity_set_path(conn, :create), commodity_set: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CommoditySet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, commodity_set_path(conn, :create), commodity_set: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    commodity_set = Repo.insert! %CommoditySet{}
    conn = put conn, commodity_set_path(conn, :update, commodity_set), commodity_set: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CommoditySet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    commodity_set = Repo.insert! %CommoditySet{}
    conn = put conn, commodity_set_path(conn, :update, commodity_set), commodity_set: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    commodity_set = Repo.insert! %CommoditySet{}
    conn = delete conn, commodity_set_path(conn, :delete, commodity_set)
    assert response(conn, 204)
    refute Repo.get(CommoditySet, commodity_set.id)
  end
end
