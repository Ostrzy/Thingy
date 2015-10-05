defmodule Component.Fight do
  @behaviour Component

  def start_link({range, damage}) do
    Component.start_link(%{
      base_range: range,
      range: range,
      base_damage: damage,
      damage: damage,
    })
  end

  def get_damage(entity) do
    Entity.get_state(entity, __MODULE__).damage
  end

  def get_base_damage(entity) do
    Entity.get_state(entity, __MODULE__).base_damage
  end

  def get_range(entity) do
    Entity.get_state(entity, __MODULE__).range
  end

  def get_base_range(entity) do
    Entity.get_state(entity, __MODULE__).base_range
  end
end
