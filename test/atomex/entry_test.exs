defmodule Atomex.EntryTest do
  use Atomex.TestCase
  doctest Atomex.Entry

  @default_id "https://example.com/entries/x"
  @default_title "Entry title"
  @default_inserted_at DateTime.from_naive!(~N[2016-05-24 13:26:08.003], "Etc/UTC")

  test "special characters get escaped" do
    expected = "<content>&lt;span&gt;Snaps &amp;!!&lt;/span&gt;</content>"
    test_field(:content, ["<span>Snaps &!!</span>"], expected)
  end

  test "can render CDATA" do
    expected = "<content type=\"html\"><![CDATA[<h1>Amazing</h1>]]></content>"
    test_field(:content, [{:cdata, "<h1>Amazing</h1>"}, [type: "html"]], expected)
  end

  describe "Optional fields" do
    test "rights" do
      test_field(:rights, ["xxx"], "<rights>xxx</rights>")
      test_field(:rights, [{:cdata, "<p>Hi</p>"}, "html"], "<rights type=\"html\"><![CDATA[<p>Hi</p>]]></rights>")
    end

    test "contributor" do
      test_field(:contributor, ["Gandhi"], "<contributor><name>Gandhi</name></contributor")
    end

    test "published" do
      expected = "<published>#{DateTime.to_iso8601(@default_inserted_at)}</published>"
      test_field(:published, [@default_inserted_at], expected)
    end

    test "category" do
      test_field :category, ["Music"], "<category term=\"Music\"/>"
    end
  end

  defp default_entry do
    Entry.new(@default_id, @default_inserted_at, @default_title)
  end

  defp test_field(field, args, expected) do
    Entry
    |> apply(field, [default_entry()] ++ args)
    |> Entry.build()
    |> XmlBuilder.generate(format: :none)
    |> assert_contains(expected)
  end
end
