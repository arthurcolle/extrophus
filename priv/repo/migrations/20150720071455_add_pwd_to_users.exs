defmodule Trophus.Repo.Migrations.AddPwdToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :pwd, :string
  	end
  end
end
