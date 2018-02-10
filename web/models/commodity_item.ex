defmodule CommodityGameApi.CommodityItem do
  use CommodityGameApi.Web, :model

  schema "commodity_items" do
    belongs_to :commodity, CommodityGameApi.Commodity, foreign_key: :commodity_id
    belongs_to :user, CommodityGameApi.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
