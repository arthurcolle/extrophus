defmodule Trophus.Repo.Migrations.AddInstaUrlToDish do
  use Ecto.Migration

  def change do
  	alter table(:dishes) do
  		add :insta_url, :string
  	end
  end
end
