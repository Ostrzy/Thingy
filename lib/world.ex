defmodule World do
  @systems [
    System.Hunger,
    System.Starvation,
    System.Roar,
    System.Death,
    System.Senses,
    System.FoodSpawner,

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

    {:ok, dragon} = Entity.init
    Entity.add_component(dragon, Component.Health, 3)
    Entity.add_component(dragon, Component.Hunger, {:meat, 40})
    Entity.add_component(dragon, Component.Sound, "Roar")
    Entity.add_component(dragon, Component.Senses)
    Entity.add_component(dragon, Component.Sense.Eyesight, 4)
    Entity.add_component(dragon, Component.AI)
    Entity.add_component(dragon, Component.AI.Hunger)
    Entity.add_component(dragon, Component.Position, {5, 5})
    Entity.add_component(dragon, Component.Movement, {5, :true})
    Entity.add_component(dragon, Component.Display, :dragon)

    Task.start_link(fn -> loop(%{entities: [dragon]}) end)
  end

  defp loop(state) do
    entities = Enum.reduce @systems, state.entities, fn (system, entities) ->
      system.run(entities)
    end
    :timer.sleep(100)
    loop(%{state | entities: entities})
  end
end
