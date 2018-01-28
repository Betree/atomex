defmodule Atomex.Feed do
  alias Atomex.Feed
  alias Atomex.Types.{Person, Link}

  defstruct id: "",
            title: "",
            updated: DateTime.utc_now(),
            # Recommended
            author: [],
            link: [],
            # Optional
            category: [],
            contributor: [],
            generator: nil,
            icon: nil,
            logo: nil,
            rights: nil,
            subtitle: nil,
            entries: nil

  @doc """
  Create a new feed
  """
  def new(id, title, last_update_datetime) do
    %Feed{
      id: id,
      title: title,
      updated: last_update_datetime
    }
  end

  @def"""
  Accepted values for params: uri, email
  """
  def author(feed = %Feed{author: existing}, name, params \\ []),
    do: Map.put(feed, :author, [Person.new(name, params) | existing])

  @def"""
  Accepted values for params: rel, type, hreflang, title, length
  """
  def link(feed = %Feed{link: existing}, href, params \\ []),
    do: Map.put(feed, :link, [Link.new(href, params) | existing])

  def entries(feed = %Feed{}, entries), do: Map.put(feed, :entries, entries)
end
