defmodule Trophus.OrderItem do
  use Trophus.Web, :model
  use Ecto.Model

  schema "order_items" do
  	belongs_to :order, Trophus.Order, foreign_key: :order_id
  	belongs_to :dish, Trophus.Dish, foreign_key: :dish_id
  	field :quantity, :integer
  	field :total_price, :integer
  	field :unit_price, :integer
  end

  # validate order_item,
  #   quantity: present(),
  #   quantity: greater_than(0)

  def unit_price(order_item) do
    order_item.dish.price
  end
  
  def total_price(order_item) do
    order_item.unit_price * order_item.quantity
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
end