defmodule Trophus.OrderController do
	use Trophus.Web, :controller
    alias Trophus.Helpers
	alias Trophus.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def order_dish(conn, params) do
    dish_id = String.to_integer(params["dish_id"])
    # Trophus.Repo.all(Trophus.Dish) |> Trophus.Repo.preload [:user]
    ordered_dish = Trophus.Repo.get(Trophus.Dish, dish_id) |> Trophus.Repo.preload [:user]
    seller = Trophus.Repo.get(Trophus.User, ordered_dish.user.id)
    #ordering_user = Trophus.Repo.get(Trophus.User, conn.private.plug_session["current_user"])
    buyer_id = String.to_integer(params["buyer_id"])
    buyer = Trophus.Repo.get(Trophus.User, ordered_dish.user.id)

    cost = ordered_dish.price

    buyer = Trophus.Repo.get(Trophus.User, buyer_id)
    changeset = params
    IO.inspect "THE PARAMS FOR ORDER DISH ARE..."
    IO.inspect params

    
    customer_id = buyer.customer_id
    connect_id = seller.connect_id
    HTTPotion.start
    content_type = "application/x-www-form-urlencoded"
    auth = "Bearer sk_test_aqQo51A1cGQEk09BCaCGmkYZ"
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

    assembled_payload_content = 
      dest<>amount<>curr<>application_fee<>customer_to_charge
    
    payload_content = assembled_payload_content

    payload = [body: payload_content, headers: headers]
    response = HTTPotion.post stripe_charges_url, payload
    IO.inspect "STRIPE RESPONSE!!!!"
    render(conn, "charge.html", response: (response.body))

    # if changeset.valid? do
    #   Repo.insert(changeset)
    #   conn
    #   |> put_flash(:info, "Order made successfully.")
    #   |> redirect(to: order_path(conn, :show))
    # else
    #   render(conn, "show.html", changeset: changeset)
    # end
    conn
  end
end