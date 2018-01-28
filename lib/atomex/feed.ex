defmodule Atomex.Feed do
  import XmlBuilder
  alias Atomex.Feed
  alias Atomex.Types.{Person, Link}
#
#  defstruct id: "",
#            title: "",
#            updated: DateTime.utc_now(),
#            # Recommended
#            author: [],
#            link: [],
#            # Optional
#            category: [],
#            contributor: [],
#            generator: nil,
#            icon: nil,
#            logo: nil,
#            rights: nil,
#            subtitle: nil,
#            entries: nil

  @doc"""
  Create a new feed
  """
  def new(id, title, last_update_datetime) do
    [
      {:id, nil, id},
      {:title, nil, title},
      {:updated, nil, DateTime.to_iso8601(last_update_datetime)}
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
