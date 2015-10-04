defmodule GameSystem do
  use Behaviour

  defcallback run([pid]) :: [pid]
end
