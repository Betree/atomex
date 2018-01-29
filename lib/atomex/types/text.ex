defmodule Atomex.Types.Text do
  @moduledoc"""
  A text as described in Atom specs.
  See [this link](https://validator.w3.org/feed/docs/atom.html#text)
  """

  import XmlBuilder

  @doc"""
  Create a new Text for the `title`, `summary` or `rights` tags.
  See [this link](https://validator.w3.org/feed/docs/atom.html#text)

  ## Parameters

    - tag: tag name (`:title`, `:summary` or `rights`)
    - content: a String or a XmlBuilder element list
    - type: a String with the content type (default=`text`). Can be:
      - html: Contains entity escaped html
      - xhtml: Contains inline xhtml, wrapped in a div element (you must pass
        content as `{:cdata, content}` if using this)
  """
  def new(tag, content, _type="text") when tag in ~w(title summary rights)a do
    element(tag, nil, content)
  end

  def new(tag, content, type) when tag in ~w(title summary rights)a do
    element(tag, %{type: type}, content)
  end
end