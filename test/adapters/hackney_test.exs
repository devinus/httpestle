defmodule HTTPestle.Adapters.HackneyTest do
  use ExUnit.Case

  setup_all do
    :application.set_env(:httpestle, :adapter, HTTPestle.Adapters.Hackney)
  end

  test "get" do
    {:ok, resp} = HTTPestle.get("http://httpbin.org/get")
    assert resp.status == 200
    assert is_list(resp.headers)
    assert is_binary(resp.body)
  end

  test "post" do
    {:ok, resp} = HTTPestle.post("http://httpbin.org/post", "payload")
    assert resp.status == 200
    assert Poison.decode!(resp.body)["data"] == "payload"
  end
end
