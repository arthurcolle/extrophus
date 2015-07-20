defmodule Trophus.CartChannel do
	use Phoenix.Channel

	def join("cart:" <> user_id, msg, socket) do
		IO.puts user_id
		{:ok, socket}
	end
	 
	def handle_in("cart_update", socket) do
    broadcast! socket, "cart_update", %{ping: 1}
    {:noreply, socket}
  end

  def handle_out("cart_update", payload, socket) do
    push socket, "cart_update", payload
    {:noreply, socket}
  end

end