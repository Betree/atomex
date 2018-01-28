defmodule Atomex do
  @moduledoc """
  Convert a feed into a ready-to-use string document
  """
  require Logger

  @doc """
  Build
  """
  def generate_document(feed) do
    XmlBuilder.doc(feed)
  end
end
