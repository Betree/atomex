defmodule Atomex.Types.Category do
  @moduledoc """
  A category as described in Atom specs. See [this link](https://validator.w3.org/feed/docs/atom.html#category)
  """

  import XmlBuilder

  @doc """
  Create a new category tag.

  ## Parameters

    - term: A string identifying the category
    - attributes: A keyword list accepting following entries:
      - scheme: identifies the categorization scheme via a URI
      - label: provides a human-readable label for display

  ## Examples

    iex> Atomex.Types.Category.new("70-s-music")
    {:category, %{term: "70-s-music"}, nil}
    iex> Atomex.Types.Category.new("70-s-music", label: "70's music")
    {:category, %{term: "70-s-music", label: "70's music"}, nil}
  """
  def new(term, attributes \\ []) do
    element(:category, Enum.into(attributes, %{term: term}))
  end
end
