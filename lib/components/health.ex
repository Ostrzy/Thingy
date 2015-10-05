defmodule Component.Health do
  use Component

  def start_link(max_hp) do
    super(%{hp: max_hp, max_hp: max_hp})
  end

  def get(entity) do
    state(entity).hp
  end

  def get_max(entity) do
    state(entity).max_hp
  end

  def alive?(entity) do
    get(entity) > 0
  end

  def heal(entity, amount) do
    update entity, fn state ->
      hp = Enum.min([state.hp + amount, state.max_hp])
      %{state | hp: hp}
    end
  end

  def damage(entity, amount) do
    update entity, fn state ->
      hp = Enum.max([state.hp - amount, 0])
      %{state | hp: hp}
    end
  end
end
