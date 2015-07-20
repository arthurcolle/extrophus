defmodule Trophus.Dish do
  use Trophus.Web, :model

  schema "dishes" do
    belongs_to :user, Trophus.User
    has_many :order_items, Trophus.OrderItem
    field :name, :string
    field :description, :string
    field :price, :integer
    field :pic_url, :string
    field :insta_url, :string
    field :es_id, :string
    timestamps
  end

  @required_fields ~w(name description price)
  @optional_fields ~w(insta_url pic_url es_id)

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
