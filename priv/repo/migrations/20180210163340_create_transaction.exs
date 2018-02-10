defmodule CommodityGameApi.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :commodity_id, references(:commodities, on_delete: :delete_all)
      add :commodity_item_id, references(:commodity_items, on_delete: :nilify_all)
      add :buyer_id, references(:users, on_delete: :nilify_all)
      add :seller_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:transactions, [:commodity_item_id])
  end
end
