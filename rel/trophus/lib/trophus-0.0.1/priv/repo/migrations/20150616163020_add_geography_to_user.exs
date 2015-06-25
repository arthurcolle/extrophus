defmodule Trophus.Repo.Migrations.AddGeographyToUser do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE users \
        ADD COLUMN latitude float, \
        ADD COLUMN longitude float, \
        ADD COLUMN home varchar(255), \
        ADD COLUMN address_line_1 varchar(255), \
        ADD COLUMN address_line_2 varchar(255), \
        ADD COLUMN address_state varchar(255), \
        ADD COLUMN address_city varchar(255), \
        ADD COLUMN address_zip varchar(255);"
  end

  def down do
    execute "ALTER TABLE users \
        DROP COLUMN customer_id varchar(255), \
        DROP COLUMN connect_id varchar(255), \
        DROP COLUMN secret_key varchar(255), \
        DROP COLUMN publishable_key varchar(255);"
  end
end
