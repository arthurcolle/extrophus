defmodule Trophus.Repo.Migrations.AddPostgisToUser do
  use Ecto.Migration
  def up do
    alter table(:users) do
      add :loc, :point
	end
  end

  def down do
    alter table(:users) do
      remove :loc
	end
  end
end
