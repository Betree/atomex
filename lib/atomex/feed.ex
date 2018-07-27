defmodule Atomex.Feed do
  @moduledoc """
  Represent an Atom feed. Embed many `Atomex.Entry`
  """

  import XmlBuilder
  alias Atomex.Types.{Person, Link, Text, Category}

  @doc """
  Create a new feed
  """
  def new(id, last_update_datetime, title, title_type \\ "text") do
    [
      {:id, nil, id},
      Text.new(:title, title, title_type),
      {:updated, nil, DateTime.to_iso8601(last_update_datetime)}
    ]
  end

  @doc """
  Must be called before build_document, once the feed is fully prepared
  """
  def build(feed, attributes \\ %{}) do
    attributes = Map.merge(%{xmlns: "http://www.w3.org/2005/Atom"}, attributes)
    element(:feed, attributes, feed)
  end

  @doc """
  Add a custom field to the feed

  ## Parameters

    - feed: The feed to which you want to add a field
    - tag: String or atom with the name of the tag
    - attributes: A map of attributes
    - content: String, or list of xml_elements as created
      by `XmlBuilder.element/3`
  """
  def add_field(feed, tag, attributes, content) do
    [element(tag, attributes, content) | feed]
  end

  @doc """
  Add a custom field to the feed

  ## Parameters

    - feed: The feed to which you want to add a field
    - xml_element: An xml element as returned by `XmlBuilder.element/3`
  """
  def add_field(feed, xml_element) do
    [xml_element | feed]
  end

  @doc """
  Add an author to the feed. See `Atomex.Types.Person` for accepted attributes
  """
  def author(feed, name, attributes \\ []),
    do: add_field(feed, Person.new(:author, name, attributes))

  @doc """
  Add a link to the feed. See `Atomex.Types.Link` for accepted attributes
  """
  def link(feed, href, attributes \\ []),
    do: add_field(feed, Link.new(href, attributes))

  @doc """
  Add given entries to the feed
  """
  def entries(feed, entries),
    do: feed ++ entries

  # ---- Optional fields ----

  @doc """
  Names one contributor to the feed.
  A feed may have multiple contributor elements.

  See `Atomex.Types.Person` for accepted attributes
  """
  def contributor(feed, name, attributes \\ []),
    do: add_field(feed, Person.new(:contributor, name, attributes))

  @doc """
  Conveys information about rights, e.g. copyrights, held in and over the feed.

  See `Atomex.Types.Text` for accepted types
  """
  def rights(feed, content, type \\ "text"),
    do: add_field(feed, Text.new(:rights, content, type))

  @doc """
  Specifies a category that the feed belongs to.
  A feed may have multiple category elements.

  See `Atomex.Types.Category` for accepted attributes
  """
  def category(feed, term, attributes \\ []),
    do: add_field(feed, Category.new(term, attributes))

  @doc """
  Identify feed generator. Default to Atomex with current version.

  ## Parameters

    - attributes:
      * uri: Generator's URI
      * version: Generator's version
  """
  def generator(feed),
    do: add_field(feed, :generator, %{version: Atomex.version()}, "Atomex")

  def generator(feed, name, attributes \\ []),
    do: add_field(feed, :generator, attributes, name)

  @doc """
  Identifies a small image which provides iconic visual identification for
  the feed. Icons should be square.
  """
  def icon(feed, uri), do: add_field(feed, :icon, nil, uri)

  @doc """
  Identifies a larger image which provides visual identification for the feed.
  Images should be twice as wide as they are tall.
  """
  def logo(feed, uri), do: add_field(feed, :logo, nil, uri)

  @doc """
  Contains a human-readable description or subtitle for the feed.

  See `Atomex.Types.Text` for accepted types
  """
  def subtitle(entry, content, type \\ "text"),
    do: add_field(entry, Text.new(:subtitle, content, type))
end
