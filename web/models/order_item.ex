defmodule Trophus.OrderItem do
  use Trophus.Web, :model
  schema "order_items" do
  	belongs_to :order, Trophus.Order
  	belongs_to :dish, Trophus.Dish
  end
end