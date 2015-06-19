defmodule Trophus.Repo.Migrations.AddDishPicUrlToDish do
  use Ecto.Migration

  def up do
    alter table(:dishes) do
      add :pic_url, :string
    end
  end

  def down do
    alter table(:dishes) do
      remove :pic_url
    end
  end
end
