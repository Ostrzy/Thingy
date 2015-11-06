defmodule System.AI.Hunger.Executor do
  alias Component.Position

  @behaviour GameSystem

  @components [
    Component.AI,
    Component.AI.Hunger,
    Component.Hunger,
    Component.Position,
    Component.Senses,
  ]

  def run(entities) do
    entities
    |> Entity.filter(@components)
    |> Enum.filter(&Component.AI.chosen?(&1, System.AI.Hunger))
    |> Enum.each(&execute(&1))

    Enum.filter(entities, &Process.alive?/1)
  end

  defp execute(entity) do
    state   = Component.AI.blackboard(entity, System.AI.Hunger)
    IO.puts "I can see: #{Enum.count(state.food)} food"
    food    = state.food |> Enum.filter(&Process.alive?/1)
    IO.puts "I can see: #{Enum.count(food)} present food"
    targets = state.targets |> Enum.filter(&Process.alive?/1)
    cond do
      Enum.count(food) > 0 ->
        eat_lying_food(entity, food)
        IO.puts("Lying food eating!")
      Enum.count(targets) > 0 && Entity.contains?(entity, Component.Fight) ->
        kill_eatable_target(entity, targets)
        IO.puts("Chasing food!")
      true ->
        look_for_food(entity)
        IO.puts("Search for food")
    end
  end

  defp closest_entity(entities, entity) do
    Enum.min_by entities, fn target ->
      %{d: dist} = distance(Position.get(entity), Position.get(target))
      dist
    end
  end

  defp distance({x1, y1}, {x2, y2}) do
    dx = x1 - x2
    dy = y1 - y2
    %{dx: dx, dy: dy, d: abs(dx) + abs(dy)}
  end

  def move_to(entity, {tx, ty}) do
    %{dx: dx, dy: dy, d: d} = distance(Position.get(entity), {tx, ty})
    range = Component.Movement.get_range entity
    if d <= range do
      Position.move_to entity, tx, ty
    else
      mx = round(dx / d * range)
      y_sign = if dy < 0 do -1 else 1 end
      my = (range - abs(mx)) * y_sign
      Position.move_by entity, -mx, -my
    end
  end

  defp go_to(target, entity) do
    {x, y}   = Position.get entity
    {tx, ty} = Position.get target
    IO.puts "I am at (#{x}, #{y}) and I go to (#{tx}, #{ty})"
    move_to(entity, Position.get(target))
    {x, y} = Position.get entity
    IO.puts "Now I am at: (#{x}, #{y})"
    target
  end

  defp eat(target, entity) do
    if Position.at?(entity, Position.get target) do
      {_, calories} = Component.Eatable.stats(target)
      Component.Hunger.eat(entity, calories)
      Agent.stop target
      IO.puts "Om nom nom: " <> to_string calories
    end
  end

  def eat_lying_food(entity, food) do
    food
    |> closest_entity(entity)
    |> go_to(entity)
    |> eat(entity)
  end

  defp kill(target, entity) do
    tpos = Position.get(target)
    epos = Position.get(entity)
    range = Component.Fight.get_range(entity)
    %{d: dist} = distance(tpos, epos)
    if dist <= range do
      damage = Component.Fight.get_damage(entity)
      Component.Health.damage(target, damage)
    end
  end

  def kill_eatable_target(entity, targets) do
    targets
    |> closest_entity(entity)
    |> go_to(entity)
    |> kill(entity)
  end

  def look_for_food(entity) do
    range = Component.Movement.get_range(entity)
    dx = :random.uniform(range + 1) - 1
    dy = range - dx
    dx = dx * Enum.random([-1, 1])
    dy = dy * Enum.random([-1, 1])
    Position.move_by(entity, dx, dy)
  end
end
