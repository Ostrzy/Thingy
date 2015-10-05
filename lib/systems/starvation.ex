defmodule System.Starvation do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, [Component.Hunger, Component.Health]) end)
    |> Enum.filter(fn entity -> Component.Hunger.hungry?(entity) end)
    |> Enum.each(fn entity -> Component.Health.damage(entity, 1) end)

    entities
  end
end
