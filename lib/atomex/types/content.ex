defmodule Atomex.Types.Content do
  import XmlBuilder

  def new(content, attributes) do
    element(:content, Enum.into(attributes, %{}), content)
  end
end