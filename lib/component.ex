defmodule Component do
  use Behaviour

  defcallback start_link(term) :: Agent.on_start

  def start_link(state) do
    Agent.start_link(fn -> state end)
  end

  def get_state(component) do
    Agent.get(component, &(&1))
  end

  def set_state(component, state) do
    Agent.update(component, fn _ -> state end)
  end

  def update_state(component, function) do
    Agent.update(component, function)
  end
end
