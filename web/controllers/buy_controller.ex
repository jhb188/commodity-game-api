defmodule CommodityGameApi.BuyController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.Buy

  def index(conn, _params) do
    buys = Repo.all(Buy)
    render(conn, "index.json", buys: buys)
  end

  def create(conn, %{"buy" => buy_params}) do
    changeset = Buy.changeset(%Buy{}, buy_params)

    case Repo.insert(changeset) do
      {:ok, buy} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", buy_path(conn, :show, buy))
        |> render("show.json", buy: buy)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    buy = Repo.get!(Buy, id)
    render(conn, "show.json", buy: buy)
  end

  def update(conn, %{"id" => id, "buy" => buy_params}) do
    buy = Repo.get!(Buy, id)
    changeset = Buy.changeset(buy, buy_params)

    case Repo.update(changeset) do
      {:ok, buy} ->
        render(conn, "show.json", buy: buy)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CommodityGameApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    buy = Repo.get!(Buy, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(buy)

    send_resp(conn, :no_content, "")
  end
end
