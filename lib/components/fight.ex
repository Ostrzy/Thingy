defmodule Component.Fight do
  use Component

  def start_link({range, damage}) do
    super(%{
      base_range: range,
      range: range,
      base_damage: damage,
      damage: damage,
    })
  end

  def get_damage(entity) do
    state(entity).damage
  end

  def get_base_damage(entity) do
    state(entity).base_damage
  end

  def get_range(entity) do
    state(entity).range
  end

  def get_base_range(entity) do
    state(entity).base_range
  end
end
