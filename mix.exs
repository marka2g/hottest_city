defmodule HottestCity.MixProject do
  use Mix.Project

  def project do
    [
      app: :hottest_city,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HottestCity.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.4"},
      {:broadway, "~> 1.0"},
      {:csv, "~> 3.2"}
    ]
  end
end
