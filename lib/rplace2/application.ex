defmodule Rplace2.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    :lines_db = :ets.new(:lines_db, [:named_table, :bag, {:write_concurrency, true}, {:read_concurrency, true}, :public])

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Rplace2.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Rplace2.Web.Endpoint, []),
      # Start your own worker by calling: Rplace2.Worker.start_link(arg1, arg2, arg3)
      # worker(Rplace2.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rplace2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
