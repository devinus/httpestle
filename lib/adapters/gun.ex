defmodule HTTPestle.Adapters.Gun do
  @behaviour HTTPestle.Adapter

  def get(url, headers) do
    uri = URI.parse(url)
    case open(uri) do
      {:ok, conn} ->
        :gun.get(conn, uri.path || "/", Map.to_list(headers))
        loop(conn, 5000)
      other ->
        other
    end
  end

  defp open(uri) do
    :gun.open(String.to_char_list(uri.host), uri.port)
  end

  defp loop(conn, timeout, data \\ "") do
    receive do
      {:gun_data, ^conn, _, _, chunk} ->
        loop(conn, data <> chunk)
      {:gun_response, ^conn, _, _, status, headers} ->
        {:ok, status, headers, data}
      any ->
        IO.inspect(any)
    after
      timeout -> {:error, :timeout}
    end
  end
end
