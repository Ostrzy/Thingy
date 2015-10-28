defmodule Server.Main do
  use GenServer

  # Public API

  def start_link(port \\ 3000, opts \\ []) do
    GenServer.start_link(__MODULE__, port, opts)
  end

  def get(self) do
    GenServer.call(self, :get_server)
  end

  def register_client(self, client) do
    GenServer.call(self, {:new_client, client})
  end

  def send(self, data) do
    GenServer.call(self, {:send, data})
  end

  # Server implementation

  def init(port) do
    case Socket.Web.listen(port) do
      {:error, reason} -> {:stop, reason}
      {:ok, server} ->
        state = %{server: server, clients: []}
        {:ok, state}
    end
  end

  def handle_call(:get_server, _from, state) do
    {:reply, state.server, state}
  end

  def handle_call({:new_client, client}, _from, state) do
    clients = [client | state.clients]
    {:reply, :ok, %{state | clients: clients}}
  end

  def handle_call({:send, data}, _from, state) do
    clients = state.clients
      |> Enum.filter(fn client -> Socket.Web.send(client, {:text, data}) == :ok end)
    {:reply, :ok, %{state | clients: clients}}
  end
end
