defmodule Atomex.FeedTest do
  use Atomex.TestCase
  doctest Atomex.Feed

  test "can add custom fields" do
    test_feed()
    |> Feed.add_field(:custom_field, %{attribute: 42}, "Foobar")
    |> Atomex.generate_document()
    |> assert_contains("<custom_field attribute=\"42\">Foobar</custom_field>")
  end

  test "can add custom schemas" do
    test_feed()
    |> Feed.build(%{"xmlns:custom" => "https://example.com"})
    |> Atomex.generate_document()
    |> assert_contains("<feed xmlns=\"http://www.w3.org/2005/Atom\" xmlns:custom=\"https://example.com\">")
  end
end