defmodule Server.Supervisor do
  use Supervisor

  @server_name Server.Main
  @server_port 8001

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init([]) do
    children = [
      worker(Server.Main, [@server_port, [name: @server_name]]),
      worker(Server.Accepter, [@server_name])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
