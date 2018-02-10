defmodule CommodityGameApi.CommoditySetController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.CommoditySet

  def index(conn, _params) do
    commodity_sets = Repo.all(CommoditySet)
    render(conn, "index.json", commodity_sets: commodity_sets)
  end

  def create(conn, %{"commodity_set" => commodity_set_params}) do
    changeset = CommoditySet.changeset(%CommoditySet{}, commodity_set_params)

    case Repo.insert(changeset) do
      {:ok, commodity_set} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", commodity_set_path(conn, :show, commodity_set))
        |> render("show.json", commodity_set: commodity_set)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    commodity_set = Repo.get!(CommoditySet, id)
    render(conn, "show.json", commodity_set: commodity_set)
  end

  def update(conn, %{"id" => id, "commodity_set" => commodity_set_params}) do
    commodity_set = Repo.get!(CommoditySet, id)
    changeset = CommoditySet.changeset(commodity_set, commodity_set_params)

    case Repo.update(changeset) do
      {:ok, commodity_set} ->
        render(conn, "show.json", commodity_set: commodity_set)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    commodity_set = Repo.get!(CommoditySet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(commodity_set)

    send_resp(conn, :no_content, "")
  end
end
