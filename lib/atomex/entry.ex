defmodule Atomex.Entry do
  import XmlBuilder
  alias Atomex.Entry
  alias Atomex.Types.{Person, Link, Text, Content}


  @doc"""
  Build a new entry
  """
  def new(id, last_update_datetime, title, title_type \\ "text") do
    [
      {:id, nil, id},
      Text.new(:title, title, title_type),
      {:updated, nil, DateTime.to_iso8601(last_update_datetime)},
    ]
  end

  @doc"""
  Must be called once the entry is fully prepared
  """
  def build(entry) do
    element(:entry, nil, entry)
  end

  @doc"""
  Names one author of the entry. An entry may have multiple authors. An entry must contain at least one author element
  unless there is an author element in the enclosing feed, or there is an author element in the enclosed source element.
  More info [here](https://validator.w3.org/feed/docs/atom.html#person).

  Accepted values for params: uri, email
  """
  def author(feed, name, params \\ []), do: [Person.new(:author, name, params) | feed]

  @doc"""
  Identifies a related Web page. The type of relation is defined by the rel attribute. An entry is limited to one
  alternate per type and hreflang. An entry must contain an alternate link if there is no content element.
  More info [here](https://validator.w3.org/feed/docs/atom.html#link).

  Accepted values for params: rel, type, hreflang, title, length
  """
  def link(feed, href, params \\ []), do: [Link.new(href, params) | feed]

  @doc"""
  Contains or links to the complete content of the entry. Content must be provided if there is no alternate link,
  and should be provided if there is no summary.

  In the most common case, the type attribute is either text, html, xhtml, in which case the content element is defined
  identically to other text constructs, which are described here.
  Otherwise, if the src attribute is present, it represents the URI of where the content can be found. The type
  attribute, if present, is the media type of the content.
  Otherwise, if the type attribute ends in +xml or /xml, then an xml document of this type is contained inline.
  Otherwise, if the type attribute starts with text, then an escaped document of this type is contained inline.
  Otherwise, a base64 encoded document of the indicated media type is contained inline.
  """
  def content(entry, content \\ "", attributes \\ []), do: [Content.new(content, attributes) | entry]

  @doc"""
  Conveys a short summary, abstract, or excerpt of the entry. Summary should be provided if there either is no content
  provided for the entry, or that content is not inline (i.e., contains a src attribute), or if the content is encoded
  in base64. More info [here](https://validator.w3.org/feed/docs/atom.html#text).
  """
  def summary(entry, summary, type \\ "text"), do: [Text.new(:summary, summary, type) | entry]
end