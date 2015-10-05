defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, [Component.Sound]) end)
    |> Enum.each(fn entity -> IO.puts Component.Sound.get(entity) end)

    entities
  end
end
