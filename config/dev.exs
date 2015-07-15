use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :trophus, Trophus.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]],
#  https: [port: 443,
#          otp_app: :trophus,
#          keyfile: System.get_env("KEYFILE"),
#          certfile: System.get_env("CERTFILE")],
  server: true

# Watch static and templates for browser reloading.
config :trophus, Trophus.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :trophus, Trophus.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "arthur",
  password: "cfill0u0pp",
  database: "trophus_dev",
  extensions: [{Geo.PostGIS.Extension, library: Geo}],
  size: 10 # The amount of database connections in the pool
