defmodule Trophus.Repo.Migrations.CreateDishTagRelation do
  use Ecto.Migration

  def change do
    create table(:dish_tag_relations) do
    	add :dish_id, references(:dishes)
    	add :tag_id, references(:tags)
      timestamps
    end

  end
end
