defmodule RtsptWeb.Router do
  use RtsptWeb, :router

  import RtsptWeb.UsersAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RtsptWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_users
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RtsptWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  ## Authentication routes

  scope "/", RtsptWeb do
    pipe_through [:browser, :require_authenticated_users]

    live_session :require_authenticated_users,
      on_mount: [{RtsptWeb.UsersAuth, :require_authenticated}] do
      live "/users/settings", UsersLive.Settings, :edit
      live "/users/settings/confirm-email/:token", UsersLive.Settings, :confirm_email
      live "/dashboard", DashboardLive, :index
    end

    post "/users/update-password", UsersSessionController, :update_password
  end

  scope "/", RtsptWeb do
    pipe_through [:browser]

    live_session :current_user,
      on_mount: [{RtsptWeb.UsersAuth, :mount_current_scope}] do
      live "/users/register", UsersLive.Registration, :new
      live "/users/log-in", UsersLive.Login, :new
      live "/users/log-in/:token", UsersLive.Confirmation, :new
    end

    post "/users/log-in", UsersSessionController, :create
    delete "/users/log-out", UsersSessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", RtsptWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rtspt_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RtsptWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
