defmodule Trophus.Repo.Migrations.CreateOrderItem do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :quantity, :integer
      add :total_price, :integer
      add :unit_price, :integer
      add :dish_id, :integer
      add :order_id, :integer

      timestamps
    end
    create index(:order_items, [:dish_id])
    create index(:order_items, [:order_id])

  end
end
