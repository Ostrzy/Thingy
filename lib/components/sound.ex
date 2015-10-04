defmodule Component.Sound do
  @behaviour Component

  def start_link(sound) do
    Component.start_link(%{sound: sound})
  end
end
