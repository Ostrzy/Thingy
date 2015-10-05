defmodule System.Death do
  @behaviour GameSystem

  def run(entities) do
    dead_entities =
      entities
      |> Enum.filter(&Entity.contains? &1, Component.Health)
      |> Enum.filter(&not Component.Health.alive? &1)

    Enum.each dead_entities, &Agent.stop/1

    entities -- dead_entities
  end
end
