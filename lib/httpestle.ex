defmodule HTTPestle do
  def get(url, headers \\ %{}) do
    adapter.get(url, headers)
  end

  defp adapter do
    case Application.get_env(:httpestle, :adapter) do
      :gun -> HTTPestle.Adapters.Gun
    end
  end
end
