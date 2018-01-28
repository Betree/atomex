# Atomex

Atomex is an ATOM 1.0 feed builder with a focus on [RFC4287](https://tools.ietf.org/html/rfc4287) compliance
and extendability.

## TODO

- [x] Feed required params (id, title, updated)
- [x] Feed recommended params (author, link)
- [ ] Feed optional params
- [ ] Entry required params (...)

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
  Feed.new("https://example.com", "My incredible feed", DateTime.utc_now)
  |> Feed.author("John Doe", email: "JohnDoe@example.com")
  |> Feed.link("https://example.com/feed", rel: "self")
  |> Feed.entries(Enum.map(comments, &get_entry/1))
  |> Atomex.build_document()
end

defp get_entry(comment) do
  Entry.new("https://example.com/comments/#{comment.id}", "New comment by #{comment.user.name}", comment.inserted_at)
  |> Entry.author(comment.user.name, uri: "https://example.com/users/#{comment.user.id}")
  |> Entry.content("#{comment.user.name}: #{comment.text}")
end
```

Some rules to remember while building your feed:
*  A feed must contain at least one author element unless all of the entry elements contain at least one author element.

See [this](https://validator.w3.org/feed/docs/atom.html) for more info about Atom specifications.