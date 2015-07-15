defmodule Trophus.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :conversation_id, references(:conversations)
      timestamps
    end

  end
end
