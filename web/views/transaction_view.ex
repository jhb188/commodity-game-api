defmodule CommodityGameApi.TransactionView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, CommodityGameApi.TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, CommodityGameApi.TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      amount: transaction.amount,
      commodity_item_id: transaction.commodity_item_id,
      buyer_id: transaction.buyer_id,
      seller_id: transaction.seller_id}
  end
end
