defmodule Twix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TwixWeb.Telemetry,
      Twix.Repo,
      {DNSCluster, query: Application.get_env(:twix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Twix.PubSub},
      # Start a worker by calling: Twix.Worker.start_link(arg)
      # {Twix.Worker, arg},
      # Start to serve requests, typically the last entry
      TwixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Twix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TwixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
