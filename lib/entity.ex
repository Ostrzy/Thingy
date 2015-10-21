defmodule Entity do
  @type t :: pid

  def init do
    Agent.start_link(fn -> HashDict.new end)
  end

  def add_component(entity, component_name, args) do
    Agent.update entity, fn components ->
      {:ok, component} = component_name.start_link(args)
      HashDict.put(components, component_name, component)
    end
  end

  def add_component(entity, component_name) do
    Agent.update entity, fn components ->
      {:ok, component} = component_name.start_link
      HashDict.put(components, component_name, component)
    end
  end

  def remove_component(entity, component_name) do
    Agent.update entity, fn components ->
      {component, updated_components} = HashDict.pop(components, component_name)
      Agent.stop component
      updated_components
    end
  end

  def get_state(entity, component_name) do
    get_for_component(entity, component_name, :get_state)
  end

  def set_state(entity, component_name, state) do
    get_for_component(entity, component_name, :set_state, [state])
  end

  def update_state(entity, component_name, updater) do
    get_for_component(entity, component_name, :update_state, [updater])
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

  def filter(entities, component_names) do
    entities |> Enum.filter(&contains?(&1, component_names))
  end

  defp get_for_component(entity, component_name, function_name, args \\ []) do
    Agent.get entity, fn components ->
      component = HashDict.get(components, component_name)
      apply(Component.Helpers, function_name, [component | args])
    end
  end
end
