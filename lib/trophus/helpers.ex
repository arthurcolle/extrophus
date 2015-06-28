defmodule Trophus.Helpers do
  alias Trophus.Repo
  alias Trophus.User
  
  def current_order(conn) do
    current_user_id = conn.private.plug_session["current_user"]
    if current_user_id != nil do
	    current_user = Repo.get(User, current_user_id)
	    order_id = Plug.Conn.get_session(conn, :order_id)
	    IO.inspect Plug.Conn
	    if (order_id != nil) do
	      Repo.get(Order, order_id)
	    else
	      # Order.new(%{buyer_id: current_user.id})
	    end
    end
  end
end