defmodule Atomex.TestCase do
  @moduledoc """
  Common test utils for Atomex
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      require Logger
      alias Atomex
      alias Atomex.{Feed, Entry}

      @last_update_date ~N[2016-05-24 13:26:08.003]
      def test_feed do
        Feed.new(
          "https://example.com/",
          DateTime.from_naive!(@last_update_date, "Etc/UTC"),
          "My incredible feed"
        )
      end

      def assert_contains(string1, string2) do
        assert String.contains?(string1, string2), "String: #{string2}\nNot found in: #{string1}"
      end
    end
  end
end
