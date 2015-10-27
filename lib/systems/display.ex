defmodule System.Display do
  @behaviour GameSystem

  def run(entities) do
    entities
    |> Entity.filter(Component.Display)
    |> Enum.map(&dump/1)
    |> to_json
    |> send_to_frontend

    entities
  end

  defp dump(entity) do
    entity
    |> Entity.components
    |> HashDict.to_list
    |> Enum.map(fn {id, component} -> {component_id(id), state(component)} end)
    |> Enum.reduce(HashDict.new, fn {id, component}, dict -> HashDict.put(dict, id, component) end)
  end

  defp component_id(id) do
    Atom.to_string(id) |> String.slice(17..-1) |> String.replace(".", "_") |> String.downcase
  end

  defp state(component) do
    Component.Helpers.get_state(component)
  end

  defp to_json(entities) do
    {:ok, json } = JSON.encode(entities)
    json
  end

  defp send_to_frontend(_json) do
    # Do nothing for now
  end
end
