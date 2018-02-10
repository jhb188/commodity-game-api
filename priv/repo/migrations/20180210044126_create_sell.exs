defmodule CommodityGameApi.Repo.Migrations.CreateSell do
  use Ecto.Migration

  def change do
    create table(:sells) do
      add :amount, :integer
      add :open, :boolean, default: false, null: false
      add :commodity_id, references(:commodities, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :commodity_item_id, references(:commodity_items, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:sells, [:commodity_id, :user_id])
    create unique_index(:sells, [:commodity_item_id])
  end
end
