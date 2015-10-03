defmodule Entity do
  def init do
    Agent.start_link(fn -> HashDict.new end)
  end

  def add_component(entity, component_name, args) do
    Agent.update entity, fn components ->
      {:ok, component} = component_name.start_link(args)
      HashDict.put(components, component_name, component)
    end
  end

  def get_state(entity, component_name) do
    Agent.get entity, fn components ->
      components
      |> HashDict.get(component_name)
      |> Component.get_state
    end
  end

  def set_state(entity, component_name, state) do
    Agent.get entity, fn components ->
      components
      |> HashDict.get(component_name)
      |> Component.set_state(state)
    end
  end

  def contains?(entity, component_name) when is_atom(component_name) do
    contains?(entity, [component_name])
  end

  def contains?(entity, component_names) do
    Agent.get entity, fn components ->
      component_names
      |> Enum.all?(fn name -> HashDict.has_key?(components, name) end)
    end
  end
end
