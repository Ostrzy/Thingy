defmodule Component.Health do
  @behaviour Component

  def start_link(max_hp) do
    Component.start_link(%{hp: max_hp, max_hp: max_hp})
  end

  def get(entity) do
    Entity.get_state(entity, __MODULE__).hp
  end

  def get_max(entity) do
    Entity.get_state(entity, __MODULE__).max_hp
  end

  def alive?(entity) do
    get(entity) > 0
  end

  def heal(entity, amount) do
    Entity.update_state entity, __MODULE__, fn state ->
      hp = Enum.min([state.hp + amount, state.max_hp])
      %{state | hp: hp}
    end
  end

  def damage(entity, amount) do
    Entity.update_state entity, __MODULE__, fn state ->
      hp = Enum.max([state.hp - amount, 0])
      %{state | hp: hp}
    end
  end
end
