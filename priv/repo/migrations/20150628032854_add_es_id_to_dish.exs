defmodule Trophus.Repo.Migrations.AddEsIdToDish do
  use Ecto.Migration

  def change do
  	alter table(:dishes) do
  		add :es_id, :string
  	end
  end
end
