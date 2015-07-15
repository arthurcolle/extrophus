defmodule Trophus.NotifChannel do
	use Phoenix.Channel

	def join("notifs:" <> user_id, msg, socket) do
		IO.puts user_id
		{:ok, socket}
	end
	 
	def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    IO.inspect payload
    {:noreply, socket}
  end

end