defmodule System.Hunger do
  @behaviour GameSystem

  def run(entities) do
    applicable_entities = Enum.filter entities, fn entity ->
      Entity.contains?(entity, Component.Hunger)
    end

    Enum.each applicable_entities, &hunger/1

    entities
  end

  defp hunger(entity) do
    hunger_state = Entity.get_state(entity, Component.Hunger)
    hunger = Enum.max([hunger_state.hunger - 1, -hunger_state.max_hunger])
    hunger_state = %{hunger_state | hunger: hunger}
    Entity.set_state(entity, Component.Hunger, hunger_state)
  end
end
