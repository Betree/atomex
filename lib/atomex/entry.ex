defmodule Atomex.Entry do
  @moduledoc"""
  A feed entry
  """

  import XmlBuilder
  alias Atomex.Types.{Person, Link, Text, Content, Category}


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
  Add a custom field to the entry

  ## Parameters

    - entry: The entry to which you want to add a field
    - tag: String or atom with the name of the tag
    - attributes: A map of attributes
    - content: String, or list of xml_elements as created by `XmlBuilder.element/3`
  """
  def add_field(entry, tag, attributes, content) do
    [element(tag, attributes, content) | entry]
  end
  @doc"""
  Add a custom field to the entry

  ## Parameters

    - entry: The entry to which you want to add a field
    - xml_element: An xml element as returned by `XmlBuilder.element/3`
  """
  def add_field(entry, xml_element) do
    [xml_element | entry]
  end

  # ---- Recommended ----

  @doc"""
  Names one author of the entry. An entry may have multiple authors. An entry must contain at least one author element
  unless there is an author element in the enclosing feed, or there is an author element in the enclosed source element.

  See `Atomex.Types.Person` for accepted attributes
  """
  def author(entry, name, attributes \\ []), do: add_field(entry, Person.new(:author, name, attributes))

  @doc"""
  Identifies a related Web page. The type of relation is defined by the rel attribute. An entry is limited to one
  alternate per type and hreflang. An entry must contain an alternate link if there is no content element.

  See `Atomex.Types.Link` for accepted attributes
  """
  def link(entry, href, attributes \\ []), do: add_field(entry, Link.new(href, attributes))

  @doc"""
  Contains or links to the complete content of the entry. Content must be provided if there is no alternate link,
  and should be provided if there is no summary.

  See `Atomex.Types.Content` for accepted attributes
  """
  def content(entry, content \\ "", attributes \\ []), do: add_field(entry, Content.new(content, attributes))

  @doc"""
  Conveys a short summary, abstract, or excerpt of the entry. Summary should be provided if there either is no content
  provided for the entry, or that content is not inline (i.e., contains a src attribute), or if the content is encoded
  in base64.

  See `Atomex.Types.Text` for accepted types
  """
  def summary(entry, summary, type \\ "text"), do: add_field(entry, Text.new(:summary, summary, type))

  # ---- Optional ----

  @doc"""
  Contains the time of the initial creation or first availability of the entry.
  """
  def published(entry, datetime), do: add_field(entry, element(:published, nil, DateTime.to_iso8601(datetime)))

  @doc"""
  Names one contributor to the entry. An entry may have multiple contributor elements.

  See `Atomex.Types.Person` for accepted attributes
  """
  def contributor(entry, name, attributes), do: add_field(entry, Person.new(:contributor, name, attributes))

  @doc"""
  Conveys information about rights, e.g. copyrights, held in and over the entry.

  See `Atomex.Types.Text` for accepted types
  """
  def rights(entry, content, type \\ "text"), do: add_field(entry, Text.new(:rights, content, type))

  @doc"""
  Specifies a category that the entry belongs to. A entry may have multiple category elements.

  See `Atomex.Types.Category` for accepted attributes
  """
  def category(entry, term, attributes), do: add_field(entry, Category.new(term, attributes))
end