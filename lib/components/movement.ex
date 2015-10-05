defmodule Component.Movement do
  use Component

  def start_link({range, flying}) do
    Component.start_link(%{base_range: range, range: range, flying: flying})
  end

  def get_range(entity) do
    state(entity).range
  end

  def get_base_range(entity) do
    state(entity).base_range
  end

  def flying?(entity) do
    state(entity).flying
  end
end
