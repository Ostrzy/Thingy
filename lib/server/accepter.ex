defmodule Server.Accepter do
  def start_link(main_server) do
    Task.start_link(fn -> accept(main_server) end)
  end

  def accept(main_server) do
    try do
      client = accept_client!(main_server)
      Server.Main.register_client(main_server, client)
    rescue
      _ -> true # Probably log something later
    end
    accept(main_server)
  end

  defp accept_client!(main_server) do
    client = main_server
      |> Server.Main.get
      |> Socket.Web.accept!
    Socket.Web.accept!(client)
    client
  end
end
