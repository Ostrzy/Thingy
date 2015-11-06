defmodule Assemblage.MeatChunk do
  @behaviour Assemblage

  def new do
    x = :random.uniform(21) - 11
    y = :random.uniform(21) - 11
    v = :random.uniform(20)

    {:ok, food} = Entity.init
    Entity.add_component(food, Component.Position, {x, y})
    Entity.add_component(food, Component.Eatable, {:meat, v})
    Entity.add_component(food, Component.Display, :meat_chunk)
    food
  end
end
