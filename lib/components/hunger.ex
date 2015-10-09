defmodule Component.Hunger do
  use Component

  def start_link(max_hunger) do
    super(%{hunger: max_hunger, max_hunger: max_hunger})
  end

  def get(entity) do
    state(entity).hunger
  end

  def get_max(entity) do
    state(entity).max_hunger
  end

  def eat(entity, amount) do
    update entity, fn state ->
      hunger = Enum.min([state.hunger + amount, state.max_hunger])
      %{state | hunger: hunger}
    end
  end

  # No idea for better function name - any suggestions?
  def famish(entity, amount) do
    update entity, fn state ->
      hunger = Enum.max([state.hunger - amount, -state.max_hunger])
      %{state | hunger: hunger}
    end
  end

  def hungry?(entity) do
    get(entity) < 0
  end

  def normalized(entity) do
    get(entity) / get_max(entity)
  end
end
