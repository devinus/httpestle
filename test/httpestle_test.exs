defmodule HTTPestleTest do
  use ExUnit.Case

  alias HTTPestle.Response

  defmodule TestAdapter do
    alias HTTPestle.Request
    alias HTTPestle.Response

    def request(%Request{method: method} = req) do
      case method do
        m when m in ~w(get head delete options)a ->
          assert req.payload == nil
        m when m in ~w(post put patch)a ->
          assert req.payload != nil
      end
      {:ok, %Response{status: 200, headers: [], body: "#{method}"}}
    end
  end

  setup_all do
    :application.set_env(:httpestle, :adapter, TestAdapter)
  end

  for method <- ~w(get head delete options)a do
    test method do
      {:ok, resp} = HTTPestle.unquote(method)("http://example.com")
      assert resp.status == 200
      assert resp.headers == []
      assert resp.body == "#{unquote(method)}"
    end

    bang_method = String.to_atom("#{method}!")
    test bang_method do
      resp = HTTPestle.unquote(bang_method)("http://example.com")
      assert resp.status == 200
      assert resp.headers == []
      assert resp.body == "#{unquote(method)}"
    end
  end

  for method <- ~w(post put patch)a do
    test method do
      {:ok, resp} = HTTPestle.unquote(method)("http://example.com", "foo")
      assert resp.status == 200
      assert resp.headers == []
      assert resp.body == "#{unquote(method)}"
    end

    bang_method = String.to_atom("#{method}!")
    test bang_method do
      resp = HTTPestle.unquote(bang_method)("http://example.com", "foo")
      assert resp.status == 200
      assert resp.headers == []
      assert resp.body == "#{unquote(method)}"
    end
  end
end
