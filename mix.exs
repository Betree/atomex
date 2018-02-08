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
      preferred_cli_env: [coveralls: :test]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:xml_builder, "~> 2.0.0"},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:sweet_xml, "~> 0.6.5", only: :test},
      {:ex_doc, "~> 0.11", only: :dev, runtime: false},
      {:earmark, "~> 0.1", only: :dev, runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
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
