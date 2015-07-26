defmodule Trophus.CartController do
  use Trophus.Web, :controller
  # import Trophus.Helpers

  plug :action

  alias Trophus.Repo
  alias Trophus.Order
  alias Trophus.Dish
  alias Trophus.User
  alias Trophus.OrderItem

  def show(conn, params) do
    user = Repo.get(User, params["user_id"])
    items = (
      Repo.get(Order, user.current_order) 
      |> Repo.preload :order_items
    )
    
    order_items_list = (
      items.order_items 
      |> Repo.preload :dish
    )
    # IO.puts "ORDER ITEMS LIST"
    # IO.inspect order_items_list
    quantity_tuple_list = []
    {:ok, agent} = Agent.start_link(fn -> [] end)
    uniq_items = Enum.uniq order_items_list, fn(oi) -> oi.dish_id end
    for uniq_item <- uniq_items do
      quantity = Enum.count order_items_list, fn(y) -> y.dish_id == uniq_item.dish_id end
      Agent.update(agent, fn list -> list ++ [{uniq_item.dish, quantity}] end)
    end
    ls = Agent.get(agent, fn x -> x end)
    render conn, "show.html", items: ls
  end

  def get_current_order(conn, %{"id" => user_id}) do
    current_user = Trophus.Repo.get(Trophus.User, user_id)
    current_order = Trophus.Repo.get(Trophus.Order, current_user.current_order)
    # IO.puts "This is the current_order"
    # IO.inspect current_order
    render(conn, "cart.html", current_order: current_order)
  end

  def add_to_cart(conn, params) do
    dish = Repo.get(Dish, params["dish_id"])
    current_user = Repo.get(User, params["current_user"])
    if current_user.current_order == nil do
      current_order_changeset = Order.changeset(%Order{}, %{"user_id" => current_user.id})
      if current_order_changeset.valid? do
        current_order_response = Repo.insert! current_order_changeset
        # IO.puts "Current order response is..."
        current_order_id = current_order_response.id
        user_current_order_changeset = User.changeset(current_user, %{current_order: current_order_response.id})
        if user_current_order_changeset.valid? do
          ucoc_response = Repo.update! user_current_order_changeset
          IO.puts "Current order USER response is..."
          IO.inspect ucoc_response
        end
      end
    else 
      # IO.puts "GOT HERE"
      current_order = Repo.get(Order, current_user.current_order)
      order_item_changeset_params = %{"dish_id" => dish.id, "order_id" => current_order.id}
      order_item_changeset = OrderItem.changeset(%OrderItem{}, order_item_changeset_params)
      # IO.puts "DO I EXIST?"
      # IO.inspect order_item_changeset
      if order_item_changeset.valid? do
        oic = Repo.insert! order_item_changeset
        # IO.puts "Adding to cart CHANGESET RESPONSE"
        # IO.inspect oic
      end
      order_items = (current_order |> Repo.preload :order_items)
      items = (order_items.order_items |> Repo.preload :dish)
      # IO.inspect items
      item_price_list = (items |> Enum.map fn(item) -> item.dish.price end)
      current_total = Enum.reduce(item_price_list, 0, &+/2)
      json conn, %{params: params, current_order_total: current_total}
    end
  end

  def get_current_order_balance(conn, params) do
    current_user = Repo.get(User, params["current_user"])
    current_order = Repo.get(Order, current_user.current_order)
    order_items = (current_order |> Repo.preload :order_items)
    items = (order_items.order_items |> Repo.preload :dish)
    item_price_list = (items |> Enum.map fn(item) -> item.dish.price end)
    current_total = Enum.reduce(item_price_list, 0, &+/2)
    json conn, %{params: params, current_order_total: current_total}
  end
end