defmodule Trophus.Repo.Migrations.AddNotifCountToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :unread, :integer, default: 0
  	end
  end
end
