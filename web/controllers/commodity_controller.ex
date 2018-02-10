defmodule CommodityGameApi.CommodityController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.Commodity

  def index(conn, _params) do
    commodities = Repo.all(Commodity)
    render(conn, "index.json", commodities: commodities)
  end

  def create(conn, %{"commodity" => commodity_params}) do
    changeset = Commodity.changeset(%Commodity{}, commodity_params)

    case Repo.insert(changeset) do
      {:ok, commodity} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", commodity_path(conn, :show, commodity))
        |> render("show.json", commodity: commodity)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    commodity = Repo.get!(Commodity, id)
    render(conn, "show.json", commodity: commodity)
  end

  def update(conn, %{"id" => id, "commodity" => commodity_params}) do
    commodity = Repo.get!(Commodity, id)
    changeset = Commodity.changeset(commodity, commodity_params)

    case Repo.update(changeset) do
      {:ok, commodity} ->
        render(conn, "show.json", commodity: commodity)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    commodity = Repo.get!(Commodity, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(commodity)

    send_resp(conn, :no_content, "")
  end
end
