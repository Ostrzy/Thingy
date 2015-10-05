defmodule Component.Movement do
  @behaviour Component

  def start_link({range, flying}) do
    Component.start_link(%{base_range: range, range: range, flying: flying})
  end

  def get_range(entity) do
    Entity.get_state(entity, __MODULE__).range
  end

  def get_base_range(entity) do
    Entity.get_state(entity, __MODULE__).base_range
  end

  def flying?(entity) do
    Entity.get_state(entity, __MODULE__).flying
  end
end
