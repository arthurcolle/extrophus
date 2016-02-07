defmodule Trophus.Repo.Migrations.AddCurrentOrderToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :current_order, references(:orders)
  	end
  end
end
