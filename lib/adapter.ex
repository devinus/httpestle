defmodule HTTPestle.Adapter do
  use Behaviour

  defcallback get(url :: String.t, headers :: map)
    :: {:ok, status :: integer, headers :: map, body :: String.t}
     | {:error, reason :: any}
end
