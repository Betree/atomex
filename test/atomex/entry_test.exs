defmodule Atomex.EntryTest do
  use ExUnit.Case

  alias Atomex.Entry

  @default_id "https://example.com/entries/x"
  @default_title "Entry title"
  @default_inserted_at DateTime.from_naive!(~N[2016-05-24 13:26:08.003], "Etc/UTC")

  test "special characters get escaped" do
    entry =
      Entry.new(@default_id, @default_inserted_at, @default_title)
      |> Entry.content("<span>Snaps &!!</span>")
      |> Entry.build()
      |> XmlBuilder.doc()

    assert String.contains?(entry, "<content>&lt;span&gt;Snaps &amp;!!&lt;/span&gt;</content>")
  end

  test "can render CDATA" do
    entry =
      Entry.new(@default_id, @default_inserted_at, @default_title)
      |> Entry.content({:cdata, "<h1>Amazing</h1>"}, type: "html")
      |> Entry.build()
      |> XmlBuilder.doc()

    assert String.contains?(entry, "<content type=\"html\"><![CDATA[<h1>Amazing</h1>]]></content>")
  end
end