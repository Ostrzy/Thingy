defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, [Component.Health, Component.Sound]) end)
    |> Enum.filter(fn entity -> Entity.get_state(entity, Component.Health).hp > 0 end)
    |> Enum.each(fn entity -> IO.puts Entity.get_state(entity, Component.Sound).sound end)
  end
end
