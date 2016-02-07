defmodule Trophus.OrderItem do
  use Trophus.Web, :model
  use Ecto.Model

  schema "order_items" do
    belongs_to :order, Trophus.Order, foreign_key: :order_id
    belongs_to :dish, Trophus.Dish, foreign_key: :dish_id
    field :quantity, :integer
    field :total_price, :integer
    field :unit_price, :integer
    timestamps
  end

  def unit_price(order_item) do
    order_item.dish.price
  end
  
  def total_price(order_item) do
    order_item.unit_price * order_item.quantity
  end
  
  @required_fields ~w(order_id dish_id)
  @optional_fields ~w(quantity total_price unit_price)

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