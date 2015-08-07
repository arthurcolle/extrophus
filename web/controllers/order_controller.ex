defmodule Trophus.OrderController do
  use Trophus.Web, :controller

  alias Trophus.Helpers
  alias Trophus.User
  alias Trophus.Dish
  alias Trophus.Repo

  plug :scrub_params, "user" when action in [:create, :update]

  def history(conn, params) do
  end

  def order_cart(conn, params) do
    current_user = 
      User
      |> Repo.get params["buyer_id"]

    current_order =
      Order
      |> Repo.get current_user.current_order

    IO.inspect current_order
  end

  def order_dish(conn, params) do
    dish_id = String.to_integer(params["dish_id"])
    ordered_dish =
      Repo.get(Dish, dish_id)
      |> Repo.preload [:user]

    seller = Repo.get(User, ordered_dish.user.id)
    buyer_id = String.to_integer(params["buyer_id"])
    buyer = Repo.get(User, ordered_dish.user.id)

    cost = ordered_dish.price

    buyer = Repo.get(User, buyer_id)
    changeset = params

    customer_id = buyer.customer_id
    connect_id = seller.connect_id
    HTTPotion.start
    content_type = "application/x-www-form-urlencoded"
    auth = "Bearer #{System.get_env("STRIPE_SECRET_KEY")}"
    stripe_charges_url = "https://api.stripe.com/v1/charges"
    headers = ["Content-type": content_type, "Authorization": auth]

    dest = "destination="<>connect_id<>"&"
    charge_amount = (Float.ceil(cost + 0.3*cost) * 100) |> Kernel.trunc
    amount = "amount="<>Integer.to_string(charge_amount)<>"&"
    curr = "currency=usd"<>"&"
    desc = "Coming soon"
    descr = "description=\"#{desc}\""<>"&"

    app_fee = Float.ceil((0.3*cost) * 100) |> Kernel.trunc
    application_fee = "application_fee="<>Integer.to_string(app_fee)<>"&"
    customer_to_charge = "customer="<>customer_id

    payload_content =
      dest<>amount<>curr<>application_fee<>customer_to_charge

    payload = [body: payload_content, headers: headers]
    response = HTTPotion.post stripe_charges_url, payload
    {:ok, decoded_response} = Poison.decode response.body
    render(conn, "charge.html", response: decoded_response, seller: seller, item: ordered_dish)
  end
end
