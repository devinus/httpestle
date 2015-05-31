defmodule HTTPestle.Adapters.HackneyTest do
  use ExUnit.Case

  setup_all do
    :application.set_env(:httpestle, :adapter, HTTPestle.Adapters.Hackney)
  end

  test "get" do
    {:ok, status, headers, body} = HTTPestle.get("http://httpbin.org/get")
    assert status == 200
    assert is_list(headers)
    assert is_binary(body)
  end

  test "post" do
    {:ok, status, _headers, body} = HTTPestle.post("http://httpbin.org/post", "payload")
    assert status == 200
    assert Poison.decode!(body)["data"] == "payload"
  end
end
