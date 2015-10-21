defmodule System.AI.Choice do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Entity.filter(Component.AI)
    |> Entity.each(&choose_ai(&1))

    entities
  end

  defp choose_ai(entity) do
    {ai, _ } = entity
    |> Component.AI.evaluations
    |> Enum.max_by(fn {_, evaluation} -> ai_score(evaluation) end)

    Component.AI.choose(entity, ai)
  end

  defp ai_score({severity, ease}) do
    :math.pow(severity + 1, 2) + ease
  end
end
