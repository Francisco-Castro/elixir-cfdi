defmodule CFDI.MixProject do
  use Mix.Project

  def project do
    [
      app: :cfdi,
      version: "4.0.8+calmecalli.1",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Construcción, sellado y timbrado de CFDI",
      package: package()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:sat_certificados, "~> 4.0"},
      {:cfdi_xml, "~> 4.0"},
      {:cfdi_transform, "~> 4.0"},
      {:cfdi_complementos, "~> 4.0"},
      {:sat_catalogos, "~> 4.0"},
      {:sat_xsd, "~> 4.0"},
      {:saxon_he, "~> 12.5"},
      {:xml_builder, "~> 2.1"},
      {:saxy, "~> 1.5"},
      {:jason, "~> 1.4"}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/MisaelMa/elixir-cfdi"},
      maintainers: ["Misael Madrigal"]
    ]
  end
end
