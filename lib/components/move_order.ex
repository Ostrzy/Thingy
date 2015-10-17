defmodule Component.MoveOrder do
  use Component

  def start_link({x, y}) do
    super(%{x: x, y: y})
  end

  def get(entity) do
    state = state(entity)
    {state.x, state.y}
  end

end
