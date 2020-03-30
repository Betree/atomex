defmodule Atomex.MixProject do
  use Mix.Project

  def project do
    [
      app: :atomex,
      version: "0.3.0",
      elixir: "~> 1.6",
      description: "ATOM feed builder with a focus on standards compliance, security and extensibility",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      docs: [extras: ["README.md"], main: "readme"],
      preferred_cli_env: [coveralls: :test],
      dialyzer: [remove_defaults: [:unknown]]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      # Core dependencies
      {:xml_builder, "~> 2.0.0"},

      # Test
      {:sweet_xml, "~> 0.6.5", only: :test},

      # Dev
      {:credo, "~> 1.3.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: :dev, runtime: false},
      {:earmark, "~> 0.1", only: :dev, runtime: false},
      {:ex_doc, "~> 0.11", only: :dev, runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
    ]
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["Benjamin Piouffle"],
     licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/Betree/atomex",
        "Docs" => "https://hexdocs.pm/atomex"
      }
    ]
  end
end
