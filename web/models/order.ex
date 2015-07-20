defmodule Trophus.Order do
  use Trophus.Web, :model

  schema "orders" do
    belongs_to :user, Trophus.User
    has_many :order_items, Trophus.OrderItem
    before_insert Trophus.Order, :set_order_status
    field :buyer_id, :integer
    field :dish_id, :integer
    field :subtotal, :integer
    timestamps
  end

#  @required_fields ~w(dish_id buyer_id subtotal)
  @required_fields ~w(buyer_id subtotal)
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

  def set_order_status do

  end
end
