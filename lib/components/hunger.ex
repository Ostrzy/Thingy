defmodule Component.Hunger do
  @behaviour Component

  def start_link(max_hunger) do
    Component.start_link(%{hunger: max_hunger, max_hunger: max_hunger})
  end
end
