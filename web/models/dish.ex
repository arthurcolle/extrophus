defmodule Trophus.Dish do
  use Trophus.Web, :model

  schema "dishes" do
    belongs_to :user, Trophus.User
    field :name, :string
    field :description, :string
    field :price, :integer

    timestamps
  end

  @required_fields ~w(name description price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
