defmodule CommodityGameApi.Repo.Migrations.CreateCommoditySet do
  use Ecto.Migration

  def change do
    create table(:commodity_sets) do
      add :name, :string

      timestamps()
    end
  end
end
