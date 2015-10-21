defmodule Component.AI do
  use Component

  def start_link do
    start_link(%{
      last_used: nil,
      chosen: nil,
      blackboard: HashDict.new,
      evaluations: HashDict.new
    })
  end

  def chosen?(entity, ai) do
    state(entity).chosen == ai
  end

  def last_used?(entity, ai) do
    state(entity).last_used == ai
  end

  def blackboard(entity, ai) do
    state(entity).blackboard |> HashDict.fetch(ai)
  end

  def evaluations(entity) do
    state(entity).evaluations
  end

  def choose(entity, ai) do
    update entity, fn state ->
      %{state | chosen: ai}
    end
  end

  def set_blackboard(entity, ai, bstate) do
    update entity, fn state ->
      blackboard = state(entity).blackboard |> HashDict.put(ai, bstate)
      %{state | blackboard: blackboard}
    end
  end

  def submit_evaluation(entity, ai, {_severity, _ease} = evaluation) do
    update entity, fn state ->
      evaluations = state(entity).evaluations |> HashDict.put(ai, evaluation)
      %{state | evaluations: evaluations}
    end
  end

  def clear_chosen(entity) do
    update entity, fn state ->
      %{state | last_used: state.chosen, chosen: nil}
    end
  end

  def clear_blackboard(entity) do
    update entity, fn state ->
      %{state | blackboard: HashDict.new}
    end
  end

  def clear_evaluations(entity) do
    update entity, fn state ->
      %{state | evaluations: HashDict.new}
    end
  end
end
