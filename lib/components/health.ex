defmodule Component.Health do
  @behaviour Component

  def start_link(max_hp) do
    Component.start_link(%{hp: max_hp, max_hp: max_hp})
  end
end
