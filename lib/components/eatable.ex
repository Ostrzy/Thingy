defmodule Component.Eatable do
  use Component

  def start_link({type, value}) do
    super(%{type: type, value: value})
  end

  def stats(entity) do
    s = state(entity)
    {s.type, s.value}
  end
end
