defmodule HTTPestle do
  @default_adapter HTTPestle.Adapters.Hackney

  alias HTTPestle.Request

  for method <- ~w(get head delete options)a do
    def unquote(method)(url, headers \\ []) do
      adapter.request(%Request{
        method: unquote(method),
        url: url,
        headers: headers
      })
    end

    bang_method = String.to_atom("#{method}!")
    def unquote(bang_method)(url, headers \\ []) do
      case unquote(method)(url, headers) do
        {:ok, response} ->
          response
        {:error, reason} ->
          raise HTTPestle.Error, reason
      end
    end
  end

  for method <- ~w(post put patch)a do
    def unquote(method)(url, headers \\ [], payload) do
      adapter.request(%Request{
        method: unquote(method),
        url: url,
        headers: headers,
        payload: payload
      })
    end

    bang_method = String.to_atom("#{method}!")
    def unquote(bang_method)(url, headers \\ [], payload) do
      case unquote(method)(url, headers, payload) do
        {:ok, response} ->
          response
        {:error, reason} ->
          raise HTTPestle.Error, reason
      end
    end
  end

  defp adapter do
    case Application.get_env(:httpestle, :adapter) do
      :undefined -> @default_adapter
      module -> module
    end
  end
end
