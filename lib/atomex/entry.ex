defmodule Atomex.Entry do
  alias Atomex.Entry
  alias Atomex.Types.{Person, Link}

  defstruct id: "",
            title: "",
            updated: "",
            # Recommended
            author: [],
            content: nil,
            link: [],
            summary: nil,
            # Optional
            category: [],
            contributor: [],
            published: nil,
            rights: nil,
            source: nil

  def new(id, title, last_update_datetime) do
    %Entry{
      id: id,
      title: title,
      updated: last_update_datetime
    }
  end

  @def"""
  Accepted values for params: uri, email
  """
  def author(entry = %Entry{author: existing}, name, params \\ []),
    do: Map.put(entry, :author, [Person.new(name, params) | existing])

  @def"""
  Accepted values for params: rel, type, hreflang, title, length
  """
  def link(entry = %Entry{link: existing}, href, params \\ []),
    do: Map.put(entry, :link, [Link.new(href, params) | existing])

  @def"""
  **MUST** be provided if there is no alternate link, and **SHOULD** be provided if
  there is no summary. More info [here](https://validator.w3.org/feed/docs/atom.html#link)
  """
  def content(entry = %Entry{}, content),
    do: Map.put(entry, :content, content)
end