defmodule World do
  @systems [
    System.Hunger,
    System.Starvation,
    System.Roar,
    System.Death,
    System.FoodSpawner,

    System.Senses,

    System.AI.PreEvaluations,
    # AI evaluation systems
    System.AI.Hunger.Evaluator,

    System.AI.Choice,
    # AI execution systems
    System.AI.Hunger.Executor,

    System.Display,
  ]

  def start_link do
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :random.seed(a, b, c)

    dragons = Enum.map(1..10, fn _ -> Assemblage.Dragon.new end)
    food = Enum.map(1..100, fn _ -> Assemblage.MeatChunk.new end)

    Task.start_link(fn -> loop(%{entities: food ++ dragons}) end)
  end

  defp loop(state) do
    entities = Enum.reduce @systems, state.entities, fn (system, entities) ->
      system.run(entities)
    end
    :timer.sleep(200)
    loop(%{state | entities: entities})
  end
end
