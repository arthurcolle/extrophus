defmodule Trophus.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users)
      add :buyer_id, references(:users)
      add :dish_id, references(:dish)
      add :subtotal, :integer
      timestamps
    end
  end
end
