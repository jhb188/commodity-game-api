defmodule CommodityGameApi.Repo.Migrations.CreateCommodityItem do
  use Ecto.Migration

  def change do
    create table(:commodity_items) do
      add :commodity_id, references(:commodities, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:commodity_items, [:commodity_id])
    create index(:commodity_items, [:user_id])
  end
end
