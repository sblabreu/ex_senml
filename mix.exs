defmodule ExSenml.MixProject do
  use Mix.Project

  @version "0.1.1"
  @description "A SenML toolset converter/normalizer"

  def project do
    [
      app: :ex_senml,
      version: @version,
      elixir: "~> 1.5",
      description: @description,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.19.1", only: :dev},
      {:jason, "~> 1.1"}
    ]
  end

  defp docs do
    [
      main: "ExSenml",
      source_ref: "v#{@version}",
      source_url: "https://github.com/sblabreu/ex_senml"
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sblabreu/ex_senml"}
    }
  end
end
