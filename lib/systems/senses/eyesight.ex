defmodule System.Sense.Eyesight do
  @behaviour GameSystem

  @required_components [Component.Senses, Component.Position, Component.Sense.Eyesight]

  def run(entities) do
    findable_entities = Entity.filter(entities, Component.Position)

    entities
    |> Enum.filter(&Entity.contains?(&1, @required_components))
    |> Enum.each(&extend_senses(&1, findable_entities))

    entities
  end

  defp extend_senses(entity, entities) do
    visible_entities = entities |> Enum.filter(&visible?(entity, &1))
    Component.Senses.extend(entity, visible_entities)
  end

  defp visible?(looking, entity) do
    alias Component.Position
    alias Component.Sense.Eyesight
    distance(Position.get(looking), Position.get(entity)) <= Eyesight.get_range(looking)
  end

  defp distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end
end
