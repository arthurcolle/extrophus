defmodule Trophus.CartController do
  use Trophus.Web, :controller
  import Trophus.Helpers

  plug :action
  
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
end