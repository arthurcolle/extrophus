defmodule Trophus.CartController do
  use Trophus.Web, :controller
  import Trophus.Helpers

  plug :action

  alias Trophus.Repo
  alias Trophus.Order
  alias Trophus.Dish
  alias Trophus.User

  def show(conn, params) do
    items = Trophus.Helpers.current_order(conn).order_items
    render conn, "show.html", items: items
  end

  def get_current_order(conn, %{"id" => user_id}) do
    current_user = Trophus.Repo.get(Trophus.User, user_id)
    current_order = Trophus.Repo.get(Trophus.Order, current_user.current_order)
    IO.puts "This is the current_order"
    IO.inspect current_order
    render(conn, "cart.html", current_order: current_order)
  end

  def add_to_cart(conn, params) do
    IO.puts "add_to_cart params"
    IO.inspect params
    dish = Repo.get(Dish, params["dish_id"])
    user = Repo.get(User, params["current_user"])
    if user.current_order == nil do
      # current_order_changeset = Order.changeset(%Order{}, %{})
      # order_item_changeset = OrderItem.changeset(%OrderItem{}, %{"dish_id" => params["dish_id"]})
    end
    json conn, %{params: params, dish_price: dish.price}
  end
end