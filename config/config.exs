# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ccdiscourse_auth,
  ecto_repos: [CcdiscourseAuth.Repo]

# Configures the endpoint
config :ccdiscourse_auth, CcdiscourseAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rX9s4hDiuDwB7qpzAL31atpa+49D+w6lYjxA3oXTYyfHLPI4o04TuDj+earMeiw+",
  render_errors: [view: CcdiscourseAuthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CcdiscourseAuth.PubSub,
  live_view: [signing_salt: "zu7S9XUs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ccdiscourse_auth, :pow,
  user: CcdiscourseAuth.Users.User,
  repo: CcdiscourseAuth.Repo

config :ccdiscourse_auth, ExOauth2Provider,
  repo: CcdiscourseAuth.Repo,
  resource_owner: CcdiscourseAuth.Users.User

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
