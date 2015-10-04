defmodule Component.Position do
  @behaviour Component

  def start_link(%{x: x, y: y}) do
    Component.start_link(%{x: x, y: y})
  end

  def get_position(entity) do
    state = Entity.get_state(entity, __MODULE__)
    {state.x, state.y}
  end

  def move_to(entity, x, y) do
    Entity.update_state(entity, __MODULE__, fn _ -> %{x: x, y: y} end)
  end

  def move_by(entity, dx, dy) do
    Entity.update_state(entity, __MODULE__, fn %{x: x, y: y} -> %{x: x + dx, y: y + dy} end)
  end
end
