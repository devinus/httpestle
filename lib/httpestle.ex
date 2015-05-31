defmodule HTTPestle do
  @default_adapter HTTPestle.Adapters.Hackney

  for method <- ~w(get head delete options)a do
    def unquote(method)(url, headers \\ []) do
      adapter.request(unquote(method), url, headers, nil)
    end
  end

  for method <- ~w(post put patch)a do
    def unquote(method)(url, headers \\ [], payload) do
      adapter.request(unquote(method), url, headers, payload)
    end
  end

  defp adapter do
    case Application.get_env(:httpestle, :adapter) do
      :undefined -> @default_adapter
      module -> module
    end
  end
end
