defmodule HTTPestleTest do
  use ExUnit.Case

  defmodule TestAdapter do
    def request(:get, _url, _headers, payload) do
      assert payload == nil
      {:ok, 200, [], "get"}
    end
  end

  setup_all do
    :application.set_env(:httpestle, :adapter, TestAdapter)
  end

  test "get" do
    {:ok, status, headers, body} = HTTPestle.get("http://example.com")
    assert status == 200
    assert headers == []
    assert body == "get"
  end
end
