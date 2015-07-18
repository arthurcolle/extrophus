defmodule Trophus.Residence do
  use Trophus.Web, :model

  schema "residences" do
    field :address_line_1, :string
    field :address_line_2, :string
    field :address_state, :string
    field :address_city, :string
    field :address_zip, :string
    field :latitude, :float
    field :longitude, :float
    field :name, :string

    timestamps
  end

  @required_fields ~w(address_line_1 address_line_2 address_state address_city address_zip latitude longitude name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
