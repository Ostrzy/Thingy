defmodule Thingy do
  use Application

  def start(_type, _args) do
    WorldSupervisor.start_link
  end
end
