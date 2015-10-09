defmodule Component.AI do
  use Component

  def start_link do
    start_link(%{used: nil})
  end

  def last_used(entity) do
    state(entity).used
  end
end
