defmodule System.Starvation do
  @behaviour GameSystem

  def run(entities) do
    entities = Enum.filter entities, fn entity ->
      Entity.contains?(entity, [Component.Hunger, Component.Health])
    end

    Enum.each(entities, &starvation/1)
  end

  defp starvation(entity) do
    hunger_state = Entity.get_state(entity, Component.Hunger)
    if hunger_state.hunger < 0 do
      hp_state = Entity.get_state(entity, Component.Health)
      hp = Enum.max([hp_state.hp - 1, 0])
      Entity.set_state(entity, Component.Health, %{hp_state | hp: hp})
    end
  end
end
