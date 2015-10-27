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
    |> Entity.filter(@components)
    |> Enum.filter(&Component.AI.chosen?(&1, System.AI.Hunger))
    |> Enum.each(&execute(&1))

    Enum.filter entities, &Process.alive?/1
  end

  defp execute(entity) do
    alias Component.Position
    targets = Component.AI.blackboard(entity, System.AI.Hunger).targets |> Enum.filter &Process.alive?/1
    if not Enum.empty? targets do
      targets
      |> Enum.min_by(fn target -> distance(Position.get(entity), Position.get(target)) end)
      |> go_to(entity)
      |> eat(entity)
    end
  end

  defp distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  defp go_to(target, entity) do
    {px, py} = Component.Position.get(entity)
    {tx, ty} = Component.Position.get(target)
    range = Component.Movement.get_range entity

    dx = abs tx - px
    dy = abs ty - py
    d = dx + dy
    dirx = if dx != 0, do: (tx - px) / dx, else: 0
    diry = if dy != 0, do: (ty - py) / dy, else: 0

    if d <= range do
      Component.Position.move_to entity, tx, ty
    else
      mx = round dx / d * range
      my = range - mx
      Component.Position.move_by entity, dirx * mx, diry * my
    end

    {x1, y1} = Component.Position.get entity
    IO.puts(to_string(x1) <> " " <> to_string(y1))
    target
  end

  defp eat(target, entity) do
    alias Component.Position
    if Position.at?(entity, Position.get target) do
      {_, calories} = Component.Eatable.stats(target)
      Component.Hunger.eat(entity, calories)
      Agent.stop target
      IO.puts "Om nom nom: " <> to_string calories
    end
  end

end
