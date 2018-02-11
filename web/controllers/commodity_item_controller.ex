defmodule CommodityGameApi.CommodityItemController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.CommodityItem

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    commodity_items = Repo.all(from ci in CommodityItem, where: ci.user_id == ^user.id)
    render(conn, "index.json", commodity_items: commodity_items)
  end

  def create(conn, %{"commodity_item" => commodity_item_params}) do
    changeset = CommodityItem.changeset(%CommodityItem{}, commodity_item_params)

    case Repo.insert(changeset) do
      {:ok, commodity_item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", commodity_item_path(conn, :show, commodity_item))
        |> render("show.json", commodity_item: commodity_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    commodity_item = Repo.get!(CommodityItem, id)
    render(conn, "show.json", commodity_item: commodity_item)
  end

  def update(conn, %{"id" => id, "commodity_item" => commodity_item_params}) do
    commodity_item = Repo.get!(CommodityItem, id)
    changeset = CommodityItem.changeset(commodity_item, commodity_item_params)

    case Repo.update(changeset) do
      {:ok, commodity_item} ->
        render(conn, "show.json", commodity_item: commodity_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    commodity_item = Repo.get!(CommodityItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(commodity_item)

    send_resp(conn, :no_content, "")
  end
end
