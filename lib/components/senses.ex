defmodule Component.Senses do
  use Component

  # Currently sense map is simple HashSet of entities
  def start_link(%HashSet{} = entities) do
    super(entities)
  end

  def get(entity) do
    state(entity)
  end

  def clear(entity) do
    update entity, fn _ -> HashSet.new end
  end

  def extend(entity, entities) do
    update entity, fn senses ->
      Enum.reduce entities, senses, fn e, map -> HashSet.put(map, e) end
    end
  end
end
