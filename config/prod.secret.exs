use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :hello_phoenix, HelloPhoenix.Endpoint,
  secret_key_base: "RsieqYq5+ENldo51eOxftSHZUMsRUII3fBmpx/b5hc6Y/vdABg3rqt2WMis+dnpJ"

# # Configure your database
# config :hello_phoenix, HelloPhoenix.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "hello_phoenix_prod",
#   size: 20 # The amount of database connections in the pool

defmodule Heroku do
  def database_config(uri) do
    parsed_uri = URI.parse(uri)
    [username, password] = parsed_uri.userinfo
                           |> String.split(":")
    [_, database] = parsed_uri.path
                    |> String.split("/")

    [{:username, username},
     {:password, password},
     {:hostname, parsed_uri.host},
     {:database, database},
     {:port, parsed_uri.port},
     {:adapter, Ecto.Adapters.Postgres}]
  end
end


config :hello_phoenix, HelloPhoenix.Repo,
  "DATABASE_URL"
  |> System.get_env
  |> Heroku.database_config