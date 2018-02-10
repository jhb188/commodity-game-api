defmodule CommodityGameApi.Commodity do
  use CommodityGameApi.Web, :model

  schema "commodities" do
    field :name, :string
    field :scarcity, :decimal
    belongs_to :commodity_set, CommodityGameApi.CommoditySet, foreign_key: :commodity_set_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :scarcity])
    |> validate_required([:name, :scarcity])
  end
end
