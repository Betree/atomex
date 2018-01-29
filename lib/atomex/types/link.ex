defmodule Atomex.Types.Link do
  @moduledoc"""
  A link as described in Atom specs. See [this link](https://validator.w3.org/feed/docs/atom.html#link)
  """

  import XmlBuilder

  @doc"""
  Create a new Link.

  ## Parameters

    - href: Address of the resource
    - attributes: A keyword list accepting following entries:
      - type: indicates the media type of the resource
      - hreflang: indicates the language of the referenced resource
      - title: human readable information about the link, typically for display purposes
      - length: the length of the resource, in bytes
      - rel: contains a single link relationship type. It can be a full URI, or one of the following
        predefined values (default=alternate)
          - alternate: an alternate representation of the entry or feed, for example a permalink to the html version of the entry, or the front page of the weblog.
          - enclosure: a related resource which is potentially large in size and might require special handling, for example an audio or video recording.
          - related: an document related to the entry or feed.
          - self: the feed itself.
          - via: the source of the information provided in the entry.
  """
  def new(href, attributes \\ []) do
    element(:link, Enum.into(attributes, %{href: href}))
  end
end