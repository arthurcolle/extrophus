defmodule HelloPhoenix.Repo.Migrations.CreateDish do
  use Ecto.Migration

  def change do
    create table(:dishes) do
      add :user_id, references(:users)
      add :name, :string
      add :description, :string
      add :price, :integer
      timestamps
    end
  end
end
