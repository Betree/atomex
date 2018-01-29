defmodule Atomex.Types.Person do
  @moduledoc"""
  A person (author or contributor) as described in Atom specs.
  See [this link](https://validator.w3.org/feed/docs/atom.html#person)
  """

  import XmlBuilder

  @doc"""
  Create a new Person for the `author` or `contributor` tags.

  ## Parameters

    - tag: tag title (`:author` or `:contributor`)
    - name: Person name as a String
    - attributes: A keyword list accepting following entries:
      - uri
      - email
  """
  def new(tag, name, attributes \\ []) when tag in ~w(author contributor)a do
    element(tag, nil, [element(:name, nil, name) | Enum.map(attributes, &value/1)])
  end

  defp value({tag, value}) when tag in ~w(uri email)a do
    element(tag, nil, value)
  end
end