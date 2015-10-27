defmodule Component.Display do
  use Component

  def start_link(identificator) do
    super(identificator)
  end

  def id(entity) do
    state(entity)
  end
end
