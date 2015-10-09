defmodule System.AI.Hunger do
  @behaviour GameSystem
  @behaviour System.AI

  def run(entities) do
    entities |> Enum.each(&set_action(&1))
  end

  def evaluate(entity) do
    if Entity.contains?(entity, Component.Hunger) do
      {severity(entity), ease(entity)}
    else
      {0, 0}
    end
  end

  defp severity(entity) do
    case Component.Hunger.normalized(entity) do
      x when x < 0 -> 1.0
      x            -> 1.0 - x
    end
  end

  defp ease(entity) do
    if Entity.contains?(entity, Component.Senses) do
      analyze_environment(entity)
      entity |> Component.AI.Hunger.state |> ease_from_state
    else
      0
    end
  end

  defp analyze_environment(entity) do
    targets = Component.Senses.get(entity) |> Enum.filter(fn e -> e != entity end)
    Component.AI.Hunger.update(entity, fn state -> %{ state | targets: targets } end)
  end

  defp ease_from_state(state) do
    ease = 0
    if length(state.targets) > 0, do: ease = ease + 0.3
    if length(state.food) > 0, do: ease = ease + 0.7
    ease
  end

  defp set_action(entity) do
    alias Component.Position
    Component.AI.Hunger.targets(entity)
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
