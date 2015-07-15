defmodule Trophus.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :sender_id, references(:users)
      add :recipient_id, references(:users)
      add :conversation_id, references(:conversations)
      timestamps
    end

  end
end
