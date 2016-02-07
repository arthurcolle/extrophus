defmodule Trophus.Repo.Migrations.CreateResidence do
  use Ecto.Migration

  def change do
    create table(:residences) do
      add :address_line_1, :string
      add :address_line_2, :string
      add :address_state, :string
      add :address_city, :string
      add :address_zip, :string
      add :latitude, :float
      add :longitude, :float
      add :name, :string

      timestamps
    end

  end
end
