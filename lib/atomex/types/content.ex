defmodule Atomex.Types.Content do
  @moduledoc """
  A content as described in Atom specs.
  See [this link](https://validator.w3.org/feed/docs/atom.html#content)
  """

  import XmlBuilder

  @doc """
  Create a new content tag.

  In the most common case, the type attribute is either text, html, xhtml, in which case the content element is defined
  identically to other text constructs, which are described here.

  Otherwise, if the src attribute is present, it represents the URI of where the content can be found. The type
  attribute, if present, is the media type of the content.

  Otherwise, if the type attribute ends in +xml or /xml, then an xml document of this type is contained inline.

  Otherwise, if the type attribute starts with text, then an escaped document of this type is contained inline.

  Otherwise, a base64 encoded document of the indicated media type is contained inline.

  ## Parameters

    - content: a String or a XmlBuilder element list
    - attributes: A keyword list accepting following entries:
      - src: represents the URI of where the content can be found
      - type: a String with the content type (default=`text`).
  """
  def new(content, attributes) do
    element(:content, Enum.into(attributes, %{}), content)
  end
end
