defmodule Component.Sound do
  use Component

  def start_link(sound) do
    super(%{sound: sound})
  end

  def get(entity) do
    state(entity).sound
  end
end
