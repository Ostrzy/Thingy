defmodule Component.Sound do
  @behaviour Component

  def start_link(sound) do
    Component.start_link(%{sound: sound})
  end

  def get(entity) do
    Entity.get_state(entity, __MODULE__).sound
  end
end
