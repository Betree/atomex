defmodule Atomex.Entry do
  import XmlBuilder
  alias Atomex.Entry
  alias Atomex.Types.{Person, Link, Content}
#
#  defstruct id: "",
#            title: "",
#            updated: "",
#            # Recommended
#            author: [],
#            content: nil,
#            link: [],
#            summary: nil,
#            # Optional
#            category: [],
#            contributor: [],
#            published: nil,
#            rights: nil,
#            source: nil

  def new(id, title, last_update_datetime) do
    [
      {:id, nil, id},
      {:title, nil, title},
      {:updated, nil, DateTime.to_iso8601(last_update_datetime)}
    ]
  end

  @doc"""
  Must be called once the entry is fully prepared
  """
  def build(entry) do
    element(:entry, nil, entry)
  end

  @def"""
  Accepted values for params: uri, email
  """
  def author(feed, name, params \\ []), do: [Person.new(:author, name, params) | feed]

  @def"""
  Accepted values for params: rel, type, hreflang, title, length
  """
  def link(feed, href, params \\ []), do: [Link.new(href, params) | feed]

  @def"""
  **MUST** be provided if there is no alternate link, and **SHOULD** be provided if
  there is no summary. More info [here](https://validator.w3.org/feed/docs/atom.html#link)
  """
  def content(entry, content \\ "", attributes \\ []), do: [Content.new(content, attributes) | entry]
end