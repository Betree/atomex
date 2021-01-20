defmodule Atomex.FeedTest do
  use Atomex.TestCase
  doctest Atomex.Feed

  test "can add custom fields" do
    test_feed()
    |> Feed.add_field(:custom_field, %{attribute: 42}, "Foobar")
    |> Atomex.generate_document()
    |> assert_contains(~s(<custom_field attribute="42">Foobar</custom_field>))
  end

  test "can add custom schemas" do
    test_feed()
    |> Feed.build(%{"xmlns:custom" => "https://example.com"})
    |> Atomex.generate_document()
    |> assert_contains(
      ~s(<feed xmlns="http://www.w3.org/2005/Atom" xmlns:custom="https://example.com">)
    )
  end

  describe "recommended fields" do
    test "link" do
      test_field(:link, ["/test"], ~s(<link href="/test"/>))
    end
  end

  describe "Optional fields" do
    test "rights" do
      test_field(:rights, ["xxx"], "<rights>xxx</rights>")

      test_field(
        :rights,
        [{:cdata, "<p>Hi</p>"}, "html"],
        "<rights type=\"html\"><![CDATA[<p>Hi</p>]]></rights>"
      )
    end

    test "contributor" do
      test_field(:contributor, ["Gandhi"], "<contributor><name>Gandhi</name></contributor")
    end

    test "category" do
      test_field(:category, ["Music"], "<category term=\"Music\"/>")
    end

    test "generator" do
      test_field(:generator, [], "<generator version=\"#{Atomex.version()}\">Atomex</generator>")
      test_field(:generator, ["Terminator"], "<generator>Terminator</generator>")

      test_field(
        :generator,
        ["Terminator", [uri: "/test"]],
        "<generator uri=\"/test\">Terminator</generator>"
      )

      test_field(
        :generator,
        ["Terminator", [version: "42"]],
        "<generator version=\"42\">Terminator</generator>"
      )
    end

    test "icon" do
      test_field(:icon, ["/icon.jpg"], "<icon>/icon.jpg</icon>")
    end

    test "logo" do
      test_field(:logo, ["/logo.jpg"], "<logo>/logo.jpg</logo>")
    end

    test "subtitle" do
      test_field(:subtitle, ["Bullet cat"], "<subtitle>Bullet cat</subtitle>")
    end
  end

  defp test_field(field, args, expected) do
    Feed
    |> apply(field, [test_feed()] ++ args)
    |> Feed.build()
    |> XmlBuilder.generate(format: :none)
    |> assert_contains(expected)
  end
end
