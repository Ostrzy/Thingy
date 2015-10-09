defmodule System.AI do
  use Behaviour

  defcallback evaluate(Entity.t) :: {float, float}

  @behaviour GameSystem

  @ais [
    Hunger
  ]

  @doc """
  It decided which AI should take control for each entity and runs the chosen one
  """
  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains?(&1, Component.AI))
    |> Enum.group_by(fn entity -> working_ai(entity) end)
    |> Enum.each fn {system, es} ->
      Enum.each(es, fn e -> Component.AI.update(e, &(%{&1 | used: system})) end)
      system.run(es)
    end

    entities
  end

  defp ai_system(ai), do: ai_to(ai, "System")
  defp ai_component(ai), do: ai_to(ai, "Component")

  defp ai_to(ai, type) do
    ai
    |> Atom.to_string
    |> String.replace("Elixir.", "#{type}.AI.", global: false, insert_replaced: 0)
    |> String.to_atom
  end

  def working_ai(entity) do
    @ais
    |> Enum.filter(&Entity.contains?(entity, ai_component(&1)))
    |> Enum.map(fn ai -> ai_system(ai) end)
    |> Enum.max_by(fn system -> system.evaluate(entity) |> ai_score end)
  end

  def ai_score({severity, ease}) do
    :math.pow(severity + 1, 2) + ease
  end
end
