defmodule Stlv.MixProject do
  use Mix.Project

  def project do
    [
      app: :stlv,
      version: "1.0.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      name: "STLV",
      source_url: "https://github.com/mwmiller/stlv",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:varu64, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    stlv - a pure Elixir type-length-value encoding
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Matt Miller"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mwmiller/stlv",
        "Encoding description" => "https://github.com/AljoschaMeyer/stlv"
      }
    ]
  end
end
