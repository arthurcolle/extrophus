defmodule Trophus.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :subtotal, :integer
      add :tax, :integer
      add :shipping, :integer
      add :total, :integer
      add :complete, :boolean, default: false

      timestamps
    end

  end
end
