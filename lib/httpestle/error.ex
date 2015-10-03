defmodule HTTPestle.Error do
  defexception [:message]

  def exception(value) do
    %__MODULE__{message: inspect(value)}
  end
end
