defmodule Component do
  def start_link(state) do
    Agent.start_link(fn -> state end)
  end

  defmacro __using__(_opts) do
    quote do
      @behaviour Component.Behaviour

      def state(entity) do
        Entity.get_state(entity, __MODULE__)
      end

      def set(entity, state) do
        Entity.set_state(entity, __MODULE__, state)
      end

      def update(entity, updater) do
        Entity.update_state(entity, __MODULE__, updater)
      end
    end
  end

  defmodule Behaviour do
    use Elixir.Behaviour

    defcallback start_link(term) :: Agent.on_start
  end

  defmodule Helpers do
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
end
