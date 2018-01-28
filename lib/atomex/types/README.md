# About types

Types are simple structs representing Links, Persons or Content
as defined [here](https://validator.w3.org/feed/docs/atom.html).

All struct attributes get added as attributes of the main tag. For
example a `Link`:

```elixir
%Atomex.Types.Link{
  href: "example.com",
  rel: "self"
}
```

Will be translated to:

```xml
<link href="example.com" relf="self"/>
```

**The only exception** to this rule is the key `__children`. When
Atomex encounters this key, it knows it should render them.