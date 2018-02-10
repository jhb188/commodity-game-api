defmodule CommodityGameApi.Buy do
  use CommodityGameApi.Web, :model

  schema "buys" do
    field :amount, :integer
    field :open, :boolean, default: false
    belongs_to :commodity, CommodityGameApi.Commodity, foreign_key: :commodity_id
    belongs_to :user, CommodityGameApi.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :open])
    |> validate_required([:amount, :open])
  end
end
