defmodule System.Senses do
  @behaviour GameSystem

  @senses [
    Eyesight
  ]

  def run(entities) do
    entities
    |> Enum.filter(&Entity.contains?(&1, Component.Senses))
    |> Enum.each(&Component.Senses.clear(&1))

    @senses
    |> Enum.each(fn sense -> sense_system(sense).run(entities) end)

    entities
  end

  defp sense_system(sense) do
    sense
    |> Atom.to_string
    |> String.replace("Elixir.", "System.Sense.", global: false, insert_replaced: 0)
    |> String.to_atom
  end
end
