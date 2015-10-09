defmodule Component.AI.Hunger do
  use Component

  def start_link do
    start_link(%{food: [], targets: []})
  end

  def food(entity) do
    state(entity).food
  end

  def targets(entity) do
    state(entity).targets
  end
end
