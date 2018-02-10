defmodule CommodityGameApi.Repo.Migrations.CreateBuy do
  use Ecto.Migration

  def change do
    create table(:buys) do
      add :amount, :integer
      add :open, :boolean, default: false, null: false
      add :commodity_id, references(:commodities, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:buys, [:commodity_id, :user_id])
  end
end
