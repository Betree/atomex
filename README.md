# Atomex

**Disclaimer:** Still in development & not ready for production

Atomex is an ATOM 1.0 feed builder with a focus on [RFC4287](https://tools.ietf.org/html/rfc4287) compliance
and extendability. Safe to use with user content: everything is escaped by default.

Built on top of [xml_builder](https://github.com/joshnuss/xml_builder/)

## TODO

- [x] Feed required params (id, title, updated)
- [x] Feed recommended params (author, link)
- [ ] Feed optional params
  * [ ] category
  * [ ] contributor
  * [ ] generator
  * [ ] icon
  * [ ] logo
  * [ ] rights
  * [ ] subtitle
- [x] Entry required params (id, title, updated)
- [x] Entry recommended params (author, content, link, summary)
- [ ] Entry optional params
  * [ ] category
  * [ ] contributor
  * [ ] published
  * [ ] rights
  * [ ] source
- [ ] Validator

## Installation

```elixir
def deps do
  [
    {:atomex, "https://github.com/Betree/atomex"}
  ]
end
```

## Basic usage

Required field must be passed in `new` functions. This means that in the example below, only `Feed.new` and `Entry.new`
are required.

```elixir
alias Atomex.{Feed, Entry}

def build_feed(comments) do
  Feed.new("https://example.com", DateTime.utc_now, "My incredible feed")
  |> Feed.author("John Doe", email: "JohnDoe@example.com")
  |> Feed.link("https://example.com/feed", rel: "self")
  |> Feed.entries(Enum.map(comments, &get_entry/1))
  |> Feed.build()
  |> Atomex.generate_document()
end

defp get_entry(_comment = %{id, text, inserted_at, user}) do
  Entry.new("https://example.com/comments/#{id}", "New comment by #{user.name}", inserted_at)
  |> Entry.author(user.name, uri: "https://example.com/users/#{user.id}")
  |> Entry.content("#{user.name}: #{text}")
  |> Entry.build()
end
```

To avoid escaping, you can pass a tuple as value like:

```elixir
Entry.content(entry, {:cdata, "<h1>Amazing</h1>"}, type: "html")
# Render as => <content type="html"><![CDATA[<h1>Amazing</h1>]]></content>
```

Some rules to remember while building your feed:
*  A feed must contain at least one author element unless all of the entry elements contain at least one author element.

See [this](https://validator.w3.org/feed/docs/atom.html) for more info about Atom specifications.