defmodule AtomexTest do
  use Atomex.TestCase
  doctest Atomex

  @last_update_date ~N[2016-05-24 13:26:08.003]
  test "full render of a simple feed" do
    result =
      Feed.new(
        "https://example.com/",
        DateTime.from_naive!(@last_update_date, "Etc/UTC"),
        "My incredible feed"
      )
      |> Feed.author("Steven Wilson", email: "steven@example.com")
      |> Feed.author("David Gilmour")
      |> Feed.link("https://example.com/feed", rel: "self")
      |> Feed.entries(Enum.map(1..2, &fake_entry/1))
      |> Feed.build()
      |> Atomex.generate_document()

    Logger.debug("Full render of a simple feed:\n" <> result)

    assert result ==
             String.trim("""
             <?xml version="1.0" encoding="UTF-8"?>
             <feed xmlns="http://www.w3.org/2005/Atom">
               <link href="https://example.com/feed" rel="self"/>
               <author>
                 <name>David Gilmour</name>
               </author>
               <author>
                 <name>Steven Wilson</name>
                 <email>steven@example.com</email>
               </author>
               <id>https://example.com/</id>
               <title>My incredible feed</title>
               <updated>2016-05-24T13:26:08.003Z</updated>
               <entry>
                 <summary>Hello World</summary>
                 <link href="https://example.com/entry/1" rel="alternate"/>
                 <content>Hello World, I&apos;m a very long content</content>
                 <author>
                   <name>Andrew Latimer</name>
                   <uri>https://example.com/users/~Andrew</uri>
                 </author>
                 <id>https://example.com/entry/1</id>
                 <title>New entry: 1</title>
                 <updated>2016-05-24T12:26:08.003Z</updated>
               </entry>
               <entry>
                 <summary>Hello World</summary>
                 <link href="https://example.com/entry/2" rel="alternate"/>
                 <content>Hello World, I&apos;m a very long content</content>
                 <author>
                   <name>Andrew Latimer</name>
                   <uri>https://example.com/users/~Andrew</uri>
                 </author>
                 <id>https://example.com/entry/2</id>
                 <title>New entry: 2</title>
                 <updated>2016-05-24T11:26:08.003Z</updated>
               </entry>
             </feed>
             """)
  end

  defp fake_entry(idx) do
    comment_last_update =
      @last_update_date
      |> NaiveDateTime.add(-3600 * idx, :seconds)
      |> DateTime.from_naive!("Etc/UTC")

    "https://example.com/entry/#{idx}"
    |> Entry.new(comment_last_update, "New entry: #{idx}")
    |> Entry.author("Andrew Latimer", uri: "https://example.com/users/~Andrew")
    |> Entry.content("Hello World, I'm a very long content")
    |> Entry.link("https://example.com/entry/#{idx}", rel: "alternate")
    |> Entry.summary("Hello World")
    |> Entry.build()
  end
end
