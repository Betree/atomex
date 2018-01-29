defmodule Atomex.Feed do
  @moduledoc"""
  Represent an Atom feed. Embed many `Atomex.Entry`
  """

  import XmlBuilder
  alias Atomex.Types.{Person, Link, Text}

  @doc"""
  Create a new feed
  """
  def new(id, last_update_datetime, title, title_type \\ "text") do
    [
      {:id, nil, id},
      Text.new(:title, title, title_type),
      {:updated, nil, DateTime.to_iso8601(last_update_datetime)},
    ]
  end

  @doc"""
  Must be called before build_document, once the feed is fully prepared
  """
  def build(feed, opt_attributes \\ %{}) do
    element(:feed, Map.merge(%{xmlns: "http://www.w3.org/2005/Atom"}, opt_attributes), feed)
  end

  @doc"""
  Add a custom field to the feed

  ## Parameters

    - feed: The feed to which you want to add a field
    - tag: String or atom with the name of the tag
    - attributes: A map of attributes
    - content: String, or list of xml_elements as created by `XmlBuilder.element/3`
  """
  def add_field(feed, tag, attributes, content) do
    [element(tag, attributes, content) | feed]
  end
  @doc"""
  Add a custom field to the feed

  ## Parameters

    - feed: The feed to which you want to add a field
    - xml_element: An xml element as returned by `XmlBuilder.element/3`
  """
  def add_field(feed, xml_element) do
    [xml_element | feed]
  end

  @doc"""
  Add an author to the feed. See `Atomex.Types.Person` for accepted attributes
  """
  def author(feed, name, attributes \\ []), do: add_field(feed, Person.new(:author, name, attributes))

  @doc"""
  Add a link to the feed. See `Atomex.Types.Link` for accepted attributes
  """
  def link(feed, href, attributes \\ []), do: add_field(feed, Link.new(href, attributes))

  @doc"""
  Add given entries to the feed
  """
  def entries(feed, entries), do: feed ++ entries
end
