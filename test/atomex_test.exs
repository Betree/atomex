defmodule AtomexTest do
  use ExUnit.Case
  import SweetXml
  alias Atomex.{Feed, Entry}

  doctest Atomex


  test "render a simple feed without entries" do
    result =
      Feed.new("https://example.com", "My incredible feed", DateTime.utc_now)
      |> Feed.author("John Doe", email: "JohnDoe@example.com")
      |> Feed.link("https://example.com/feed", rel: "self")
      |> Atomex.build_document()

    assert result == String.trim("""
    <?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <title>My incredible feed</title>
    <id>https://example.com</id>
    """)
  end
end
