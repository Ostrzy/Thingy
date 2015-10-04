defmodule Component.Hunger do
  @behaviour Component

  def start_link(max_hunger) do
    Component.start_link(%{hunger: max_hunger, max_hunger: max_hunger})
  end

  def get(entity) do
    Entity.get_state(entity, __MODULE__).hunger
  end

  def get_max(entity) do
    Entity.get_state(entity, __MODULE__).max_hunger
  end

  def eat(entity, amount) do
    Entity.update_state entity, __MODULE__, fn state ->
      hunger = Enum.min([state.hunger + amount, state.max_hunger])
      %{state | hunger: hunger}
    end
  end

  # No idea for better function name - any suggestions?
  def famish(entity, amount) do
    Entity.update_state entity, __MODULE__, fn state ->
      hunger = Enum.max([state.hunger - amount, -state.max_hunger])
      %{state | hunger: hunger}
    end
  end

  def hungry?(entity) do
    get(entity) < 0
  end
end
