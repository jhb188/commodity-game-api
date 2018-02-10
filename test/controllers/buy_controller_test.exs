defmodule CommodityGameApi.BuyControllerTest do
  use CommodityGameApi.ConnCase

  alias CommodityGameApi.Buy
  @valid_attrs %{amount: 42, open: true}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, buy_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    buy = Repo.insert! %Buy{}
    conn = get conn, buy_path(conn, :show, buy)
    assert json_response(conn, 200)["data"] == %{"id" => buy.id,
      "commodity_id" => buy.commodity_id,
      "user_id" => buy.user_id,
      "amount" => buy.amount,
      "open" => buy.open}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, buy_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, buy_path(conn, :create), buy: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Buy, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, buy_path(conn, :create), buy: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    buy = Repo.insert! %Buy{}
    conn = put conn, buy_path(conn, :update, buy), buy: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Buy, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    buy = Repo.insert! %Buy{}
    conn = put conn, buy_path(conn, :update, buy), buy: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    buy = Repo.insert! %Buy{}
    conn = delete conn, buy_path(conn, :delete, buy)
    assert response(conn, 204)
    refute Repo.get(Buy, buy.id)
  end
end
