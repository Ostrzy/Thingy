defmodule System.Hunger do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains? &1, Component.Hunger)
    |> Enum.each(&Component.Hunger.famish &1, 1)

    entities
  end
end
