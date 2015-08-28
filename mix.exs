defmodule Trophus.Mixfile do
  use Mix.Project

  def project do
    [app: :trophus,
     version: "0.0.3",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     # build_embedded: Mix.env == :prod,
     # start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Trophus, []},
      applications: 
        [ 
          :cowboy, :logger, :poison,
          :phoenix, :phoenix_html, :phoenix_ecto,
          :postgrex, :jsx, :erlastic_search, 
          :instagram, :instagrab
        ]
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:cowboy, "~> 1.0"}, 
     {:phoenix, "~> 1.0.0"},
     {:phoenix_ecto, "~> 1.1.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "2.1.1"},
     {:phoenix_live_reload, "~> 1.0"},
     {:comeonin, "1.0.5", [optional: false, hex: :comeonin, override: true]},
     {:hackney, "1.2.0", [optional: false, hex: :hackney, override: true]},
     {:jsx, "~> 2.6.2", [optional: false, override: true]},
     {:exrm, "0.17.1"},
     {:instagram, "0.0.3", [github: "arthurcolle/exstagram"]},
     {:compare, "0.0.1", [github: "trophus/compare"]},
     {:passport, "~> 0.0.3", [github: "trophus/passport"]},
     {:ibrowse, github: "cmullaparthi/ibrowse"}, # default adapter
     {:httpotion, "~> 2.1.0"},
     {:poison, "~> 1.4.0"},
     {:instagrab, "0.0.1", [github: "arthurcolle/instagrab"]},
     {:erlastic_search, github: "tsloughter/erlastic_search"},
     {:facebook, "~> 0.4.0"}
   ]
  end
end
