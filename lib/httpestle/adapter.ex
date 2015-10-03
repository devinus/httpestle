defmodule HTTPestle.Adapter do
  use Behaviour

  defcallback request(req :: %HTTPestle.Request{})
    :: {:ok, %HTTPestle.Response{}}
     | {:error, reason :: any}
end
