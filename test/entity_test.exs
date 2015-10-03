defmodule EntityTest do
  use ExUnit.Case

  setup do
    {:ok, entity} = Entity.init
    {:ok, %{entity: entity}}
  end

  test "adding component to entity", %{entity: entity} do
    Entity.add_component(entity, Component.Health, 3)
    assert Entity.contains?(entity, Component.Health) == true
  end

  test "adding multiple components to entity", %{entity: entity} do
    Entity.add_component(entity, Component.Health, 3)
    Entity.add_component(entity, Component.Hunger, 3)
    assert Entity.contains?(entity, [Component.Health, Component.Hunger]) == true
  end
end
