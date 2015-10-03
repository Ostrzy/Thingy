defmodule System.Roar do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Enum.filter(fn entity -> Entity.contains?(entity, Component.Health) end)
    |> Enum.filter(fn entity -> Entity.get_state(entity, Component.Health).hp > 0 end)
    |> Enum.each(fn _ -> IO.puts "Roar!" end)
  end
end
