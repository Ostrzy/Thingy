defmodule System.Movement do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains? &1, [Component.Position, Component.Movement, Component.MoveOrder])
    |> Enum.each(&move/1)

    entities
  end

  defp move(entity) do
    {px, py} = Component.Position.get entity
    {tx, ty} = Component.MoveOrder.get entity
    range = Component.Movement.get_range entity

    dx = abs tx - px
    dy = abs ty - py
    d = dx + dy
    dirx = (tx - px) / dx
    diry = (ty - py) / dy

    if d <= range do
      Component.Position.move_to entity, tx, ty
      Entity.remove_component entity, Component.MoveOrder
    else
      mx = round dx / d * range
      my = range - mx
      Component.Position.move_by entity, dirx * mx, diry * my
    end

    {x1, y1} = Component.Position.get entity
    IO.puts(to_string(x1) <> " " <> to_string(y1))
  end
end
