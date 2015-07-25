defmodule Trophus.CartController do
  use Trophus.Web, :controller
  # import Trophus.Helpers

  plug :action

  alias Trophus.Repo
  alias Trophus.Order
  alias Trophus.Dish
  alias Trophus.User
  alias Trophus.OrderItem

  # def show(conn, params) do
  #   items = Trophus.Helpers.current_order(conn).order_items
  #   render conn, "show.html", items: items
  # end

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
    current_user = Repo.get(User, params["current_user"])
    if current_user.current_order == nil do
      current_order_changeset = Order.changeset(%Order{}, %{"user_id" => current_user.id})
      if current_order_changeset.valid? do
        current_order_response = Repo.insert! current_order_changeset
        IO.puts "Current order response is..."
        current_order_id = current_order_response.id
        user_current_order_changeset = User.changeset(current_user, %{current_order: current_order_response.id})
        if user_current_order_changeset.valid? do
          ucoc_response = Repo.update! user_current_order_changeset
          IO.puts "Current order USER response is..."
          IO.inspect ucoc_response
        end
        # %Trophus.Order{__meta__: %Ecto.Schema.Metadata{source: "orders",
        #   state: :loaded}, complete: false, id: 1,
        #  inserted_at: #Ecto.DateTime<2015-07-25T00:03:26Z>,
        #  order_items: #Ecto.Association.NotLoaded<association :order_items is not loaded>,
        #  shipping: nil, subtotal: nil, tax: nil, total: nil,
        #  updated_at: #Ecto.DateTime<2015-07-25T00:03:26Z>,
        #  user: #Ecto.Association.NotLoaded<association :user is not loaded>, user_id: 1}
      end
      # order_item_changeset = OrderItem.changeset(%OrderItem{}, %{"dish_id" => params["dish_id"]})
    else 
      current_order = Repo.get(Order, current_user.current_order)
      order_item_changeset_params = %{"dish_id" => dish.id, "order_id" => current_order.id}
      order_item_changeset = OrderItem.changeset(%OrderItem{}, order_item_changeset_params)
      IO.puts "DO I EXIST?"
      IO.inspect order_item_changeset
      if order_item_changeset.valid? do
        oic = Repo.insert! order_item_changeset
        IO.puts "Adding to cart CHANGESET RESPONSE"
        IO.inspect oic
      end

    end
    json conn, %{params: params, dish_price: dish.price}
  end
end