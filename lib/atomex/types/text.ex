defmodule Atomex.Types.Text do
  import XmlBuilder

  def new(tag, content, _type="text") when tag in ~w(title summary rights)a do
    element(tag, nil, content)
  end

  def new(tag, content, type) when tag in ~w(title summary rights)a do
    element(tag, %{type: type}, content)
  end
end