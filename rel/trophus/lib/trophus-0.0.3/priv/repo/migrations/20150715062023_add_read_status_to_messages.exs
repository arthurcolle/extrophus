defmodule Trophus.Repo.Migrations.AddReadStatusToMessages do
  use Ecto.Migration

  def change do
  	alter table(:messages) do
  		add :read, :boolean
  	end
  end
end
