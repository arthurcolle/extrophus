defmodule Trophus.Repo.Migrations.CreateInterest do
  use Ecto.Migration

  def change do
    create table(:interests) do
      add :name, :string
      timestamps
    end

  end
end
