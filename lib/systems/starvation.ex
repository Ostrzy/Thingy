defmodule System.Starvation do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains? &1, [Component.Hunger, Component.Health])
    |> Enum.filter(&Component.Hunger.hungry? &1)
    |> Enum.each(&Component.Health.damage &1, 1)

    entities
  end
end
