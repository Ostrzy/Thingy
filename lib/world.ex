defmodule World do
  @systems [
    System.Hunger,
    System.Starvation,
    System.Roar
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
    Enum.each @systems, fn (system) -> system.run(state.entities) end
    :timer.sleep(100)
    loop(state)
  end
end
