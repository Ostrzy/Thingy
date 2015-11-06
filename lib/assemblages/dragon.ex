defmodule Assemblage.Dragon do
  @behaviour Assemblage

  def new do
    x = :random.uniform(11) - 6
    y = :random.uniform(11) - 6
    f = :random.uniform(10) + 10
    hp = :random.uniform(10) + 10

    {:ok, dragon} = Entity.init
    Entity.add_component(dragon, Component.Health, hp)
    Entity.add_component(dragon, Component.Hunger, {:meat, f})
    Entity.add_component(dragon, Component.Sound, "Roar")
    Entity.add_component(dragon, Component.Senses)
    Entity.add_component(dragon, Component.Sense.Eyesight, 4)
    Entity.add_component(dragon, Component.AI)
    Entity.add_component(dragon, Component.AI.Hunger)
    Entity.add_component(dragon, Component.Position, {x, y})
    Entity.add_component(dragon, Component.Movement, {2, :true})
    Entity.add_component(dragon, Component.Display, :dragon)
    Entity.add_component(dragon, Component.Fight, {1, 5})
    dragon
  end
end
