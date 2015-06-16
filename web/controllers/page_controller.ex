defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
  	url = Instagram.start
    render conn, "index.html", url: url
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def auth_callback(conn, params) do
  	IO.puts "zebra"
  	token = Instagram.get_token! %{:code => params["code"]}
  	user_recent_media = Instagram.user_recent_media(token)
  	user_data = user_recent_media["data"]
  	url_list = user_data |> Enum.map fn(x) -> x["images"]["thumbnail"]["url"] end
 	render conn, "instagram.html", images: url_list
  end
end
