defmodule Atomex do
  @moduledoc """
  Generate a valid XML string from an `Atomex.Feed` using [xml_builder](https://github.com/joshnuss/xml_builder)
  """

  @doc """
  Build and render the document into a string.
  This is where the `<?xml version="1.0" encoding="UTF-8"?>` tag is added and where strings are escaped.

  ## Parameters

    - feed: an `Atomex.Feed`
  """
  def generate_document(feed) do
    XmlBuilder.doc(feed)
  end
end
