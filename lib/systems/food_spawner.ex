defmodule System.FoodSpawner do
  @behaviour GameSystem

  def run(entities) do
    if :random.uniform > 0.8 do
      entities
    else
      generate_food ++ entities
    end
  end

  defp generate_food do
    n = :random.uniform(5)
    Enum.map(1..n, fn _ -> Assemblage.MeatChunk.new end)
  end
end
