defmodule Trophus.Repo.Migrations.AddInstagramTokenToUser do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :instagram_token, :string
    end
  end

  def down do
    alter table(:users) do
      remove :instagram_token
    end
  end
end
