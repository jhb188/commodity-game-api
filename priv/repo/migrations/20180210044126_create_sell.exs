defmodule CommodityGameApi.Repo.Migrations.CreateSell do
  use Ecto.Migration

  def change do
    create table(:sells) do
      add :amount, :integer
      add :commodity_id, references(:commodities, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :commodity_item_id, references(:commodity_items, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:sells, [:commodity_id, :user_id])
    create unique_index(:sells, [:commodity_item_id])
  end
end
