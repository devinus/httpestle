defmodule HTTPestle.Response do
  @type t :: %__MODULE__{
    status: 100..599,
    headers: [{String.t, String.t}],
    body: String.t
  }

  defstruct [
    status: nil,
    headers: nil,
    body: nil
  ]
end
