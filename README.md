# Atomex

[![Coverage Status](https://coveralls.io/repos/github/Betree/atomex/badge.svg?branch=master)](https://coveralls.io/github/Betree/atomex?branch=master)
[![Build Status](https://travis-ci.org/Betree/atomex.svg?branch=master)](https://travis-ci.org/Betree/atomex)

Atomex is an ATOM 1.0 feed builder with a focus on [RFC4287](https://tools.ietf.org/html/rfc4287) compliance,
security and extensibility. It is safe to use it with user content: everything is escaped by default.
Built on top of [xml_builder](https://github.com/joshnuss/xml_builder/).

API reference is available here: https://hexdocs.pm/atomex/api-reference.html

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
  * [x] category
  * [x] contributor
  * [x] published
  * [x] rights
  * [ ] source
- [ ] Validator

## Installation

```elixir
def deps do
  [
    {:atomex, "0.2.0"}
  ]
end
```

## Basic usage

Required field are always passed in `new` functions. There are however recommended fields that you
should not ignore. See [Validating your feed](#validating-your-feed) below.

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
  Entry.new("https://example.com/comments/#{id}", inserted_at, "New comment by #{user.name}")
  |> Entry.author(user.name, uri: "https://example.com/users/#{user.id}")
  |> Entry.content("<h1>Content here will be properly escaped! Text: #{text}</h1>", type: "html")
  |> Entry.build()
end
```

To avoid escaping, you can pass a tuple as value like this (be careful though, a user may
break it with malicious content):

```elixir
Entry.content(entry, {:cdata, "<h1>Amazing</h1>"}, type: "html")
# Render as => <content type="html"><![CDATA[<h1>Amazing</h1>]]></content>
```

## Extending the default API

* You can specify custom schemas

```elixir
Feed.build(feed, %{"xmlns:georss" => "http://www.georss.org/georss"})
# <?xml version="1.0" encoding="UTF-8"?>
# <rss version="2.0" xmlns="http://www.w3.org/2005/Atom" xmlns:georss="http://www.georss.org/georss">
#...
```

* And custom fields

```elixir
Feed.new(...)
|> Feed.add_field(:custom_field, %{attribute: 42}, "Foobar")
|> Feed.build()
|> Atomex.generate_document()
# ...
# <custom_field attribute="42">Foobar</custom_field>
```

For more complicated use cases, content can also be given a xml element directly. Use XmlBuilder to achieve that.

## Validating your feed

Use [this tool from W3C](https://validator.w3.org/feed/)