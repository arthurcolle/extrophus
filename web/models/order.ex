defmodule Trophus.Order do
  use Trophus.Web, :model

  schema "orders" do
    belongs_to :user, Trophus.User
    has_many :order_items, Trophus.OrderItem
    before_insert Trophus.Order, :set_order_status

    field :subtotal, :integer
    field :tax, :integer
    field :shipping, :integer
    field :total, :integer
    field :complete, :boolean, default: false
    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(subtotal tax shipping total complete)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def set_order_status do
  end

end
