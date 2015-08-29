use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :trophus, Trophus.Endpoint,
  # http: [port: 80],
  http: [port: {:system, "PORT"}],
  url: [host: "www.trophus.com"],
  cache_static_manifest: "priv/static/manifest.json",
  check_origin: false

  # https: [port: 443,
  #         otp_app: :trophus,
  #         keyfile: System.get_env("KEYFILE"),
  #         certfile: System.get_env("CERTFILE")]
config :trophus, Trophus.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "arthur",
  password: "cfill0u0pp",
  database: "trophus_dev",
 # extensions: [{Geo.PostGIS.Extension, library: Geo}],
  pool_size: 10 # The amount of database connections in the pool


# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config :trophus, Trophus.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

# Do not print debug messages in production
config :logger, level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :trophus, Trophus.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"
