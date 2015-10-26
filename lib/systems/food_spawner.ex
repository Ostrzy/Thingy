defmodule System.FoodSpawner do
  @behaviour GameSystem

  def run(entities) do
    x = :random.uniform(11) - 1
    y = :random.uniform(11) - 1
    v = :random.uniform(20)

    {:ok, food} = Entity.init
    Entity.add_component(food, Component.Position, {x, y})
    Entity.add_component(food, Component.Eatable, {:meat, v})

    [food | entities]
  end
end
