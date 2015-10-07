defmodule Component.Sense.Eyesight do
  use Component

  def start_link(range) do
    super(%{base_range: range, range: range})
  end

  def get_range(entity) do
    state(entity).range
  end

  def get_base_range(entity) do
    state(entity).base_range
  end
end
