defmodule CommodityGameApi.Repo.Migrations.CreateCommodity do
  use Ecto.Migration

  def change do
    create table(:commodities) do
      add :name, :string
      add :scarcity, :decimal
      add :commodity_set_id, references(:commodity_sets, on_delete: :nothing)

      timestamps()
    end

    create index(:commodities, [:commodity_set_id])
  end
end
