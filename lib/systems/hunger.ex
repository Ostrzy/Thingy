defmodule System.Hunger do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, Component.Hunger) end)
    |> Enum.each(fn entity -> Component.Hunger.famish(entity, 1) end)

    entities
  end
end
