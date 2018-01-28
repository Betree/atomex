defmodule Atomex do
  @moduledoc """
  Convert a feed into a ready-to-use string document
  """
  require Logger

  @doc """
  Build
  """
  def build_document(feed = %Atomex.Feed{}) do
    feed
    |> Map.from_struct()
    |> Enum.reduce([], &render_feed_element/2)
    |> IO.inspect()
    |> XmlBuilder.doc()
    |> IO.inspect()
  end

  defp render_feed_element({key, value}, feed)
  when key in ~w(id title)a
  do
    Keyword.put(feed, key, value)
  end
#
#  def render_feed_element({key, value}, feed)
#  when key in ~()a

  defp render_feed_element({key, value}, feed) do
    Logger.warn("Feed: #{key} not implemented")
    feed
  end
end
