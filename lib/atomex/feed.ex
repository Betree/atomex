defmodule Atomex.Feed do
  import XmlBuilder
  alias Atomex.Feed
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
  def build(feed) do
    element(:feed, %{xmlns: "http://www.w3.org/2005/Atom"}, feed)
  end

  @doc"""
  Accepted values for params: uri, email
  """
  def author(feed, name, params \\ []), do: [Person.new(:author, name, params) | feed]

  @doc"""
  Accepted values for params: rel, type, hreflang, title, length
  """
  def link(feed, href, params \\ []), do: [Link.new(href, params) | feed]

  def entries(feed, entries), do: feed ++ entries
end
