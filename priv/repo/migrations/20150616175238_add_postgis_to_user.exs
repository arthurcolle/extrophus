defmodule Trophus.Repo.Migrations.AddPostgisToUser do
  use Ecto.Migration
  def up do
    alter table(:users) do
      add :geom, :geometry
	end
  end

  def down do
    alter table(:users) do
      remove :geom
	end
  end
end
