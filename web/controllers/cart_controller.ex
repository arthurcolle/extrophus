defmodule Trophus.CartController do
  use Trophus.Web, :controller
  import Trophus.Helpers

  plug :action
  
  def show(conn, params) do
    items = Trophus.Helpers.current_order(conn).order_items
    render conn, "show.html", items: items
  end
end