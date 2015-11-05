defmodule System.AI.Hunger.Evaluator do
  @behaviour GameSystem

  @components [
    Component.AI,
    Component.AI.Hunger,
    Component.Hunger,
    Component.Senses
  ]

  def run(entities) do
    entities
    |> Entity.filter(@components)
    |> Enum.each(&Component.AI.submit_evaluation(&1, System.AI.Hunger, evaluate(&1)))

    entities
  end

  defp evaluate(entity) do
    {severity(entity), ease(entity)}
  end

  defp severity(entity) do
    case Component.Hunger.normalized(entity) do
      x when x < 0 -> 1.0
      x            -> 1.0 - x
    end
  end

  defp ease(entity) do
    analyze_environment(entity) |> ease_from_state
  end

  defp analyze_environment(entity) do
    entities = Component.Senses.get(entity) |> Enum.filter(fn e -> e != entity end)
    # Things that can be eaten after killed
    targets = entities |> Entity.filter(Component.Health)
    # Directly eatable entities
    food = entities |> Entity.filter(Component.Eatable)
    state = %{targets: targets, food: food}
    Component.AI.set_blackboard(entity, System.AI.Hunger, state)
    state
  end

  defp ease_from_state(state) do
    ease = 0
    if length(state.targets) > 0, do: ease = ease + 0.3
    if length(state.food) > 0, do: ease = ease + 0.7
    ease
  end
end
