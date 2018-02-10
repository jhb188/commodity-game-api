defmodule CommodityGameApi.Transaction do
  use CommodityGameApi.Web, :model

  schema "transactions" do
    field :amount, :integer
    belongs_to :commodity, CommodityGameApi.Commodity, foreign_key: :commodity_id
    belongs_to :commodity_item, CommodityGameApi.CommodityItem, foreign_key: :commodity_item_id
    belongs_to :buyer, CommodityGameApi.User, foreign_key: :buyer_id
    belongs_to :seller, CommodityGameApi.User, foreign_key: :seller_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount])
    |> validate_required([:amount])
  end
end
