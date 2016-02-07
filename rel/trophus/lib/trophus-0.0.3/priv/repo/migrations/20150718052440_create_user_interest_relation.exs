defmodule Trophus.Repo.Migrations.CreateUserInterestRelation do
  use Ecto.Migration

  def change do
    create table(:user_interest_relations) do
    	add :user_id, references(:users)
    	add :interest_id, references(:interests)
      timestamps
    end

  end
end
