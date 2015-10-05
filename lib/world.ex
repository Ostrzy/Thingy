defmodule World do
  @systems [
    System.Hunger,
    System.Starvation,
    System.Roar,
    System.Death
  ]

  def start_link do
    {:ok, dragon} = Entity.init
    Entity.add_component(dragon, Component.Health, 3)
    Entity.add_component(dragon, Component.Hunger, 3)
    Entity.add_component(dragon, Component.Sound, "Roar")

    {:ok, cat} = Entity.init
    Entity.add_component(cat, Component.Health, 1)
    Entity.add_component(cat, Component.Sound, "Meow")

    Task.start_link(fn -> loop(%{entities: [dragon, cat]}) end)
  end

  defp loop(state) do
    #Jak znasz jakiś sprytny trik na capture tego run, żeby nie trzeba było lambdy robić,
    #to się podziel
    entities = Enum.reduce @systems, state.entities, fn (system, entities) -> system.run(entities) end
    :timer.sleep(100)
    loop( %{state | entities: entities} )
  end
end
