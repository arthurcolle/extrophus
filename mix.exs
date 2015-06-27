defmodule Trophus.Mixfile do
  use Mix.Project

  def project do
    [app: :trophus,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Trophus, []},
  #   applications: [:phoenix, :phoenix_html, :cowboy, :logger,
  #                  :phoenix_ecto, :postgrex]]
  #

      applications: [:phoenix, :hackney, :phoenix_ecto, :exrm, 
                     :postgrex, :phoenix_html, 
                     :cowboy, :mogrify, :instagram, :compare, :erlport, 
                     :passport, :geo, :ibrowse, :httpotion, 
                     :poison, :nestedmap, :instagrab, :erlastic_search]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.13.0"},
     {:comeonin, "~> 1.0", [optional: false, hex: :comeonin, override: true]},
     {:hackney, "~> 1.0", [optional: false, hex: :hackney, override: true]},
     {:phoenix_ecto, "~> 0.4"},
     {:exrm, "0.17.1"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 1.0"},
     {:phoenix_live_reload, "~> 0.4", only: :dev},
     {:cowboy, "~> 1.0"}, 
     {:mogrify, "~> 0.1.0"},
     {:instagram,"0.0.2", [github: "arthurcolle/exstagram"]},
     {:compare, "0.0.1", [github: "trophus/compare"]},
     {:erlport, git: "https://github.com/hdima/erlport.git"},
     {:passport, "~> 0.0.3", [github: "trophus/passport"]},
     {:geo, "~> 0.13.0"},
     {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"}, # default adapter
     {:httpotion, "~> 2.1.0"},
     {:poison, "1.4.0"},
     {:nestedmap, "0.0.1", [github: "arthurcolle/nestedmap"]},
     {:instagrab, "0.0.1", [github: "arthurcolle/instagrab"]},
     {:erlastic_search, github: "arthurcolle/erlastic_search"},
     {:tirexs, "~> 0.7.0"}
   ]
  end
end
