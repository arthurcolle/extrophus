defmodule Trophus.Repo.Migrations.AddProfileDataToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
      add :bio, :string
  	end
  end
end
