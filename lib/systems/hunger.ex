defmodule System.Hunger do
  @behaviour GameSystem

  def run(entities) do
    entities = Enum.filter entities, fn entity ->
      Entity.contains?(entity, Component.Hunger)
    end

    Enum.each entities, &hunger/1

    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, Component.Health) end)
    |> Enum.each(&starvation/1)
  end

  defp hunger(entity) do
    hunger_state = Entity.get_state(entity, Component.Hunger)
    hunger = Enum.max([hunger_state.hunger - 1, -hunger_state.max_hunger])
    hunger_state = %{hunger_state | hunger: hunger}
    Entity.set_state(entity, Component.Hunger, hunger_state)
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