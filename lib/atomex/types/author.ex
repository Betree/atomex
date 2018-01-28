defmodule Atomex.Types.Person do
  import XmlBuilder

  def new(tag, name, params \\ []) when tag in ~w(author contributor)a do
    element(tag, nil, [element(:name, nil, name) | Enum.map(params, &value/1)])
  end

  defp value({tag, value}) when tag in ~w(uri email)a do
    element(tag, nil, value)
  end
end