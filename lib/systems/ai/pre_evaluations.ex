defmodule System.AI.PreEvaluation do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Entity.filter(Component.AI)
    |> clear_blackboards
    |> clear_choice
    |> clear_evaluations
  end

  defp clear_choice(entities) do
    Enum.each entities, &Component.AI.clear_chosen(&1)
    entities
  end

  defp clear_blackboards(entities) do
    Enum.each entities, &Component.AI.clear_blackboard(&1)
    entities
  end

  defp clear_evaluations(entities) do
    Enum.each entities, &Component.AI.clear_evaluations(&1)
    entities
  end
end
