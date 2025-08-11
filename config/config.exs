# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :rtspt, :scopes,
  users: [
    default: true,
    module: Rtspt.Accounts.Scope,
    assign_key: :current_scope,
    access_path: [:users, :id],
    schema_key: :users_id,
    schema_type: :binary_id,
    schema_table: :users,
    test_data_fixture: Rtspt.AccountsFixtures,
    test_setup_helper: :register_and_log_in_users
  ]

# Configure Mix tasks and generators
config :rtspt,
  ecto_repos: [Rtspt.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :rtspt, Rtspt.Mailer, adapter: Swoosh.Adapters.Local

config :rtspt_web,
  ecto_repos: [Rtspt.Repo],
  generators: [context_app: :rtspt, binary_id: true]

# Configures the endpoint
config :rtspt_web, RtsptWeb.Endpoint,
  url: [host: "0.0.0.0"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: RtsptWeb.ErrorHTML, json: RtsptWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Rtspt.PubSub,
  live_view: [signing_salt: "TzjxVgYN"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  rtspt_web: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../apps/rtspt_web/assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.7",
  rtspt_web: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("../apps/rtspt_web", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
