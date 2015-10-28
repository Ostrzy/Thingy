defmodule Thingy do
  use Application

  def start(_type, _args) do
    ThingySupervisor.start_link
  end
end
