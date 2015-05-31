defmodule HTTPestle.Adapters.Hackney do
  @behaviour HTTPestle.Adapter

  def request(method, url, headers, nil) do
    request(method, url, headers, "")
  end

  def request(method, url, headers, payload) do
    {:ok, status, resp_headers, client} = :hackney.request(method, url, headers, payload)
    {:ok, body} = :hackney.body(client)
    {:ok, status, resp_headers, body}
  end
end
