defmodule Component.Position do
  use Component

  def start_link({x, y}) do
    super(%{x: x, y: y})
  end

  def get(entity) do
    state = state(entity)
    {state.x, state.y}
  end

  def move_to(entity, x, y) do
    update(entity, fn _ -> %{x: x, y: y} end)
  end

  def move_by(entity, dx, dy) do
    update(entity, fn %{x: x, y: y} -> %{x: x + dx, y: y + dy} end)
  end
end
