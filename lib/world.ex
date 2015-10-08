defmodule World do
  @systems [
    System.Hunger,
    System.Starvation,
    System.Roar,
    System.Death,
    System.Senses,
  ]

  def start_link do
    {:ok, dragon} = Entity.init
    Entity.add_component(dragon, Component.Health, 3)
    Entity.add_component(dragon, Component.Hunger, 3)
    Entity.add_component(dragon, Component.Sound, "Roar")
    Entity.add_component(dragon, Component.Senses)
    Entity.add_component(dragon, Component.Sense.Eyesight, 4)
    Entity.add_component(dragon, Component.Position, {0, 0})

    {:ok, cat} = Entity.init
    Entity.add_component(cat, Component.Health, 1)
    Entity.add_component(cat, Component.Sound, "Meow")
    Entity.add_component(cat, Component.Position, {1, 1})

    Task.start_link(fn -> loop(%{entities: [dragon, cat]}) end)
  end

  defp loop(state) do
    entities = Enum.reduce @systems, state.entities, fn (system, entities) ->
      system.run(entities)
    end
    :timer.sleep(100)
    loop(%{state | entities: entities})
  end
end
