defmodule HTTPestle.Adapters.Hackney do
  @behaviour HTTPestle.Adapter

  alias HTTPestle.Request
  alias HTTPestle.Response

  def request(%Request{} = req) do
    %Request{method: method, url: url, headers: headers, payload: payload} = req
    case :hackney.request(method, url, headers, payload || "") do
      {:ok, status, resp_headers, client} ->
        {:ok, body} = :hackney.body(client)
        {:ok, %Response{status: status, headers: resp_headers, body: body}}
      error ->
        error
    end
  end
end
