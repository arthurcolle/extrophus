use Mix.Config

# Configures the endpoint
config :trophus, Trophus.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "+Zz2pj3D2W0R2NQiZFYbEjST9g+9UMyjfgKjgsZtivMN+f8XVOCycBkkyDHFrheO",
  debug_errors: false,
  pubsub: [name: Trophus.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :passport,
  repo: Trophus.Repo,
  user_class: Trophus.User