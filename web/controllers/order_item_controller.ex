defmodule Trophus.OrderItemController do
  use Trophus.Web, :controller
  
  def create(conn, params) do
    @order = Trophus.Helpers.current_order(conn)
    @order_item = @order.order_items.new(params)
    @order.save
    # session[:order_id] = @order.id
    put_session(conn, :order_id, @order.id)
    conn
  end

  def update(conn, params) do
    @order = Trophus.Helpers.current_order(conn)
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(params)
    @order_items = @order.order_items
    conn
  end

  def destroy(conn, params) do
    @order = Trophus.Helpers.current_order(conn)
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    conn
  end

  # defp order_item_params do
  #   params.require(:order_item).permit(:quantity, :dish_id)
  # end
end