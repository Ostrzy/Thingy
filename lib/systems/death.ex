defmodule System.Death do
  @behaviour GameSystem

  def run(entities) do
    dead_entities = Enum.filter entities, fn entity ->
      Entity.contains?(entity, Component.Health)
      and Entity.get_state(entity, Component.Health).hp == 0
    end

    Enum.each dead_entities, &Agent.stop/1

    entities -- dead_entities
  end
end
