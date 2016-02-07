defmodule Trophus.Repo.Migrations.AddStripeToUser do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE users \
        ADD COLUMN customer_id varchar(255), \
        ADD COLUMN connect_id varchar(255), \
        ADD COLUMN secret_key varchar(255), \
        ADD COLUMN publishable_key varchar(255);"
  end

  def down do
    execute "ALTER TABLE users \
        DROP COLUMN customer_id varchar(255), \
        DROP COLUMN connect_id varchar(255), \
        DROP COLUMN secret_key varchar(255), \
        DROP COLUMN publishable_key varchar(255);"
  end
end
