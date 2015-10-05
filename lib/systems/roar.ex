defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, [Component.Sound]) end)
    |> Enum.each(fn entity -> IO.puts Entity.get_state(entity, Component.Sound).sound end)

    entities
  end
end
