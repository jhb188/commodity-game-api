defmodule CommodityGameApi.SellController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.Sell

  def index(conn, _params) do
    sells = Repo.all(Sell)
    render(conn, "index.json", sells: sells)
  end

  def create(conn, %{"sell" => sell_params}) do
    changeset = Sell.changeset(%Sell{}, sell_params)

    case Repo.insert(changeset) do
      {:ok, sell} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", sell_path(conn, :show, sell))
        |> render("show.json", sell: sell)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sell = Repo.get!(Sell, id)
    render(conn, "show.json", sell: sell)
  end

  def update(conn, %{"id" => id, "sell" => sell_params}) do
    sell = Repo.get!(Sell, id)
    changeset = Sell.changeset(sell, sell_params)

    case Repo.update(changeset) do
      {:ok, sell} ->
        render(conn, "show.json", sell: sell)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sell = Repo.get!(Sell, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sell)

    send_resp(conn, :no_content, "")
  end
end
