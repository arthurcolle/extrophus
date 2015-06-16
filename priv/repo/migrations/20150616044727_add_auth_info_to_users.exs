defmodule HelloPhoenix.Repo.Migrations.AddAuthInfoToUsers do
  use Ecto.Migration

  def up do
  	  # execute "ALTER TABLE users ADD COLUMN username varchar(200);"
  	  execute "ALTER TABLE users ADD COLUMN hash varchar(130);"
  	  execute "ALTER TABLE users ADD COLUMN recovery_hash varchar(130);"
  	  execute "ALTER TABLE users ADD CONSTRAINT u_constraint UNIQUE (email);"
  end

  def down do
  	  # execute "ALTER TABLE users DROP COLUMN username varchar(200);"
  	  execute "ALTER TABLE users DROP COLUMN hash varchar(130);"
  	  execute "ALTER TABLE users DROP COLUMN recovery_hash varchar(130);"
  	  execute "ALTER TABLE users DROP CONSTRAINT u_constraint UNIQUE (email);"
  end
end
