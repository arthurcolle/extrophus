defmodule Trophus.Repo.Migrations.AddUserIdToOrders do
  use Ecto.Migration

  def change do
  	alter table(:orders) do
  		add :user_id, references(:users)
  	end
  end
end
