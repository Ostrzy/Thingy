defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, [Component.Health, Component.Sound]) end)
    |> Enum.filter(fn entity -> Component.Health.alive?(entity) end)
    |> Enum.each(fn entity -> IO.puts Component.Sound.get(entity) end)

    entities
  end
end
