defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains? &1, Component.Sound)
    |> Enum.each(&IO.puts Component.Sound.get(&1))

    entities
  end
end
