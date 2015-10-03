defmodule GameSystem do
  use Behaviour

  defcallback run([pid]) :: any
end
