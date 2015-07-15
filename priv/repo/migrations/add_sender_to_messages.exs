defmodule Trophus.Repo.Migrations.AddSenderToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :sender_id, references(:users)
      add :recipient_id, references(:users)
      timestamps
    end
  end
end
