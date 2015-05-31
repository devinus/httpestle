defmodule HTTPestle.Adapter do
  use Behaviour

  defcallback request(method :: atom, url :: String.t, headers :: list, payload :: nil | iodata)
    :: {:ok, status :: integer, headers :: list, body :: String.t}
     | {:error, reason :: any}
end
