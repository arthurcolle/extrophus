use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :trophus, Trophus.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# # Configure your database
# config :trophus, Trophus.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   url: System.get_env("DATABASE_URL"),
#   size: 20 # The amount of database connections in the pool


config :trophus, Trophus.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "arthur",
  password: "cfill0u0pp",
  database: "trophus_dev",
#  extensions: [{Geo.PostGIS.Extension, library: Geo}],
 #   extensions: [{Geo.PostGIS.Extension, library: Geo}],
  pool_size: 20 # The amount of database connections in the pool