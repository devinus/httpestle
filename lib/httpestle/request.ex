defmodule HTTPestle.Request do
  @type t :: %__MODULE__{
    method: :get | :head | :post | :put | :delete | :options | :patch,
    url: String.t,
    headers: [{String.t, String.t}],
    payload: nil | String.t
  }

  defstruct [
    method: nil,
    url: nil,
    headers: nil,
    payload: nil
  ]
end
