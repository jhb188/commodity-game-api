defmodule CommodityGameApi.BuyController do
  use CommodityGameApi.Web, :controller

  alias CommodityGameApi.Buy

  def index(conn, %{"sort" => sort, "commodity_id" => commodity_id}) do
    # TODO: abstract validation into custom plug
    order_by = case sort do
      "amount" -> [asc: :amount]
      "-amount" -> [desc: :amount]
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{ message: "'sort' must be one of ['-amount','amount']" })
    end

    buys_with_users = from b in Buy,
      where: b.commodity_id == ^commodity_id,
      order_by: ^order_by,
      order_by: [asc: :inserted_at],
      limit: 25,
      join: u in CommodityGameApi.User,
      where: u.id == b.user_id

    buys = Repo.all(
      from [b, u] in buys_with_users, select: %{
        id: b.id,
        commodity_id: b.commodity_id,
        amount: b.amount,
        username: u.username,
      }
    )

    render(conn, "index.json", buys: buys)
  end

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{ message: "'sort' and 'commodityId' params are required" })
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
