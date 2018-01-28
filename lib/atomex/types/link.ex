defmodule Atomex.Types.Link do
  import XmlBuilder

  def new(href, params \\ []) do
    element(:link, Enum.into(params, %{href: href}))
  end
end