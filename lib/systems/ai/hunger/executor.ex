defmodule System.AI.Hunger.Executor do
  # It's very rough prototype for now
  @behaviour GameSystem

  @components [
    Component.AI,
    Component.AI.Hunger,
    Component.Hunger,
    Component.Position,
    Component.Senses
  ]

  def run(entities) do
    entities
    |> Enum.filter(@components)
    |> Enum.filter(&Component.AI.chosen?(&1, __MODULE__))
    |> Enum.each(&set_action(&1))

    entities
  end

  defp set_action(entity) do
    alias Component.Position
    Component.AI.blackboard(entity, __MODULE__).targets
    |> Enum.min_by(fn target -> distance(Position.get(entity), Position.get(target)) end)
    |> go_to(entity)
  end

  defp distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  defp go_to(target, entity) do
    {x1, y1} = Component.Position.get(entity)
    {x2, y2} = Component.Position.get(target)
    case {x1 - x2, y1 - y2} do
      {0, 0}               -> :none
      {0, dy} when dy > 0 -> :down
      {0, dy} when dy < 0 -> :up
      {dx, _} when dx > 0 -> :left
      {dx, _} when dx < 0 -> :right
    end
    # Here use the direction in some way
  end

end
