defmodule Trophus.Repo.Migrations.CreateConversation do
  use Ecto.Migration

  def change do
    create table(:conversations) do
    	add :from_id, references(:users)
    	add :to_id, references(:users)
      timestamps
    end
  end
end
